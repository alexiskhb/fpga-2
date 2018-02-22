#define _USE_MATH_DEFINES
#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>
#include <sstream>
#include <fcntl.h>
#include <string>
#include <limits>
#include <ctime>
#include <chrono>
#include <functional>
#include <random>
#include <mutex>
#include <cmath>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/mman.h>
#include <netinet/in.h>
#include <fstream>

#include "processing.h"
#include "pinger.h"
#include "json/json.hpp"

#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>

#define DEVICE_NAME "/dev/channel0"

#define AXI_XADC_IOCTL_BASE       'W'
#define AXI_HANDLE_INTERRUPT      _IO(AXI_XADC_IOCTL_BASE, 0)
#define AXI_XADC_SET_PID          _IO(AXI_XADC_IOCTL_BASE, 1)
#define AXI_XADC_DMA_CONFIG       _IO(AXI_XADC_IOCTL_BASE, 2)
#define AXI_XADC_DMA_START        _IO(AXI_XADC_IOCTL_BASE, 3)
#define AXI_XADC_DMA_STOP         _IO(AXI_XADC_IOCTL_BASE, 4)
#define AXI_XADC_SET_THRESHOLD    _IO(AXI_XADC_IOCTL_BASE, 5)
#define AXI_XADC_SET_FREQUENCY    _IO(AXI_XADC_IOCTL_BASE, 6)
#define AXI_XADC_GET_THRESHOLD    _IO(AXI_XADC_IOCTL_BASE, 7)
#define AXI_XADC_GET_FREQUENCY    _IO(AXI_XADC_IOCTL_BASE, 8)
#define AXI_XADC_REARM            _IO(AXI_XADC_IOCTL_BASE, 9)

#define SIG_DATA_READY            55
#define FIFO_SIZE                 8192


#pragma pack(push,1)
typedef struct {
    int preamble;
    unsigned char beacon_type;
    unsigned short arrival_time[4];
} dsp_data;
#pragma pack(pop)

static union {
    dsp_data data_out;
    unsigned char data_buf[sizeof(dsp_data)];
};

template <typename Duration, typename Function>
void timer(const Duration& d, const Function& f) {
    std::thread([d, f](){
        std::this_thread::sleep_for(d);
        f();
    }).detach();
}

int sock, listener;
struct sockaddr_in addr;
std::mutex delays_ready_send_mutex;
bool delays_ready_send = false;
double hilbert_threshold;

unsigned char *buffer;

static void handle_signal(int n, siginfo_t *info, void *unused);

unsigned int calc_fft_freq_comp(int freq)
{
    unsigned int freq_comp = freq / 620;
    unsigned int up_half = ((freq_comp / 2) << 16);
    unsigned int down_half = freq_comp % 2;
    return up_half | down_half;
}

unsigned int calc_phase_inc(int freq)
{
    double phase_inc = (double)freq / 100.0 * pow((double)2.0, 32) / 1e6 + 0.5; 
    return phase_inc;
}


class Driver 
{
public:
    using json = nlohmann::json;

    void send(int cmd, unsigned long arg)
    {
        ioctl(ham_driver, cmd, arg);
        std::cout << "ioctl " << cmd << " " << arg << std::endl;
    }

    void send(int cmd) {
        ioctl(ham_driver, cmd);
        std::cout << "ioctl " << cmd << std::endl;
    }

    int recv(int cmd) {
        return ioctl(ham_driver, cmd);
    }

    int recv(int cmd, std::vector<data_type>& out_data) 
    {
        int blocks_num = 4;
        int block_size = 1024;
        int buf_len = block_size*blocks_num;
        out_data.resize(buf_len);
        unsigned short *draw_data_ptr = reinterpret_cast<unsigned short *>(buffer);
        for (int i = 0; i < FIFO_SIZE / 2; i+=4) {
            out_data[i / 4 + 0 * FIFO_SIZE / 8] = draw_data_ptr[i + 0];
            out_data[i / 4 + 1 * FIFO_SIZE / 8] = draw_data_ptr[i + 1];
            out_data[i / 4 + 2 * FIFO_SIZE / 8] = draw_data_ptr[i + 2];
            out_data[i / 4 + 3 * FIFO_SIZE / 8] = draw_data_ptr[i + 3];
        }
        return blocks_num;
    }

    bool is_ready() 
    {
        return true;
    }

    bool init(const char* name) 
    {
        ham_driver = open(name, O_RDWR);
        if (ham_driver < 0) {
            std::cerr << "failed open ham device" << std::endl;
            return false;
        }
        buffer = static_cast<unsigned char *>(mmap(0, FIFO_SIZE, PROT_READ, MAP_SHARED, ham_driver, 0));
        load_config();
        init_signal();
        create_tcp_threads();
        ioctl(ham_driver, AXI_XADC_DMA_START);
        return true;
    }

    void wait() {
        timer(std::chrono::milliseconds(500), [this](){ioctl(ham_driver, AXI_XADC_REARM);});
    }

private:

    void init_signal()
    {
        sig.sa_sigaction = handle_signal;
        sig.sa_flags = SA_SIGINFO;
        sigaction(SIG_DATA_READY, &sig, NULL);
        send(AXI_XADC_SET_PID, getpid());
    }

    bool create_tcp_threads()
    {
        listener = socket(AF_INET, SOCK_STREAM, 0);
        if (listener < 0) {
            std::cout << "failed to create socket" << std::endl;
            return false;
        }

        addr.sin_family = AF_INET;
        addr.sin_port = htons(3425);
        addr.sin_addr.s_addr = htonl(INADDR_ANY);
        if (bind(listener, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
            std::cout << "failed to bind socket" << std::endl;
            return false;
        }

        std::cout << "start listen" << std::endl;
        listen(listener, 1);
        std::cout << "finish listen" << std::endl;

        std::thread([this](){
            int error_code;
            socklen_t error_code_size = sizeof(error_code);
            while (1) {
                std::cout << "try accept" << std::endl;
                sock = accept(listener, NULL, NULL);
                if (sock < 0) {   
                    std::cout << "can't accept" << std::endl;
                    sleep(1);
                    continue;
                }
                std::cout << "client connected" << std::endl;

                std::thread([this](){
                    while (1) {
                        std::uint8_t command;
                        if (::recv(sock, &command, sizeof(command), 0) > 0) {
                            if (33 <= command && command <= 60) {
                                std::cout <<  "client recv command " << (int)command << std::endl;
                                send(AXI_XADC_SET_FREQUENCY, command);
                            }
                        }
                    }
                }).detach();

                while (1) {
                    std::this_thread::sleep_for(std::chrono::milliseconds(10));
                    if (delays_ready_send) {
                        delays_ready_send_mutex.lock();
                        delays_ready_send = false;
                        delays_ready_send_mutex.unlock();
                        if (::send(sock, data_buf, sizeof(dsp_data), 0) < 0) {
                            std::cout << "client disconnected" << std::endl;
                            close(sock);
                            break;
                        } else {
                            std::cout << "client send" << std::endl;
                        }
                    }
                    getsockopt(sock, SOL_SOCKET, SO_ERROR, &error_code, &error_code_size);
                    if (error_code) {
                        std::cout << "client disconnected" << std::endl;
                        close(sock);
                        break;       
                    }
                }
            }
        }).detach();
        return true;
    }

    bool load_config()
    {
        std::ifstream config_file("/home/config.json");
        if (config_file.is_open()) {
            json config;
            config_file >> config;
            hilbert_threshold = config.at("hilbert_threshold").get<double>();
            send(AXI_XADC_SET_THRESHOLD, config.at("fft_threshold").get<int>());
            send(AXI_XADC_SET_FREQUENCY, calc_fft_freq_comp(config.at("frequency").get<int>()));
        } else {
            std::cout << "failed to open config" << std::endl;
            return false;
        }
        return true;
    }

    int ham_driver;
    bool m_is_ready;
    struct sigaction sig;
};

std::mutex json_mutex;
Driver driver;

std::mutex processing_mutex;

std::vector<data_type> data;
std::vector<fourier_type> fourier_result;
std::vector<hilbert_type> hilbert_result;
std::vector<data_type> delays;

std::mutex data_ready_send_mutex;
bool data_ready_send = false;
int blocks_num;
int block_size;

static void handle_signal(int n, siginfo_t *info, void *unused) 
{
    std::cout << "handle signal" << std::endl;
    processing_mutex.lock();
    blocks_num = driver.recv(0, data);
    delays.resize(blocks_num);
    block_size = data.size()/blocks_num;
    process_ping_guilbert(data.data(), blocks_num, block_size, delays.data(), hilbert_threshold, hilbert_result, fourier_result);
    data_ready_send = true;
    processing_mutex.unlock();
    for (int i = 0; i < blocks_num; ++i) {
        data_out.arrival_time[i] = delays[i];
    }
    delays_ready_send_mutex.lock();
    delays_ready_send = true;
    delays_ready_send_mutex.unlock();
    driver.wait();
}

class WebClientRequest: public Fastcgipp::Request<wchar_t>
{
public:
    using json = nlohmann::json;

    WebClientRequest() : Fastcgipp::Request<wchar_t>(5*1024)
    {
        std::cerr << "Request created" << std::endl;
    }
private:
    enum Mode {
        fpga_sim_mode = 0, serv_sim_mode = 1, real_mode = 2, apply_settings = 3
    };
    enum EventType{SettingsGet = 0, SettingsSet, StopDMA, StartDMA, Pending, StartNavigTest, DrawData};
    double post_d1, post_d2, post_d3, post_d4, post_hilbert_threshold;
    int post_slice_beg, post_slice_end, post_frequency, post_sim_frequency, post_fft_threshold;
    int post_pulse_len, post_amplitude, post_sample_rate, mode, post_pulse_rep;
    int post_event_type;
    std::vector<int> post_delays;
private:
    template <class T>
    using json_to_variable = std::vector<std::pair<std::reference_wrapper<T>, std::string>>;

    template <class T>
    void read_json(const json& post, json_to_variable<T> map) 
    {
        for (auto& p: map) {
            try {
                T t = post.at(p.second);
                p.first.get() = t;
            } catch (const json::exception& e) {
                if (e.id != 403) {
                    std::cerr << e.what() << '\n';
                }
            }
        }
    }

    bool inProcessor()
    {
        std::lock_guard<std::mutex> gd(json_mutex);
        std::cerr << "inProcessor started" << std::endl;
        const json post = json::parse(environment().postBuffer().begin(), environment().postBuffer().end());
        std::vector<int> v;
        read_json<int>(post, {
            {mode, "mode"},
            {post_event_type, "eventType"},
        });
        if (post_event_type == StartDMA || post_event_type == StopDMA) {
            driver.send(post_event_type == StartDMA ? AXI_XADC_DMA_START : AXI_XADC_DMA_STOP);
            return true;
        }
        if (post_event_type == SettingsGet) {
            return true;
        }
        read_json<int>(post, {
            {post_slice_beg, "sliceBeg"},
            {post_slice_end, "sliceEnd"},
            {post_frequency, "frequency"},
            {post_pulse_len, "pulseLen"},
            {post_amplitude, "amplitude"},
            {post_sample_rate, "sampleRate"},
            {post_fft_threshold, "fftThreshold"},
            {post_sim_frequency, "simFrequency"},
            {post_pulse_rep, "pulseRep"},
        });
        read_json<std::vector<int>>(post, {
            {v, "slice"},
            {post_delays, "delays"},
        });
        post_slice_beg = v.front();
        post_slice_end = v.back();

        read_json<double>(post, {
            {post_d1, "d1"},
            {post_d2, "d2"},
            {post_d3, "d3"},
            {post_d4, "d4"},
            {post_hilbert_threshold, "hilbertThreshold"},
        });
        std::cerr << std::endl;
        if (post_event_type == SettingsSet) {
            if (mode == fpga_sim_mode || mode == real_mode) {
                driver.send(AXI_XADC_SET_THRESHOLD, post_fft_threshold);
                driver.send(AXI_XADC_SET_FREQUENCY, post_frequency);
            }
            processing_mutex.lock();
            hilbert_threshold = post_hilbert_threshold;
            processing_mutex.unlock();
        }
        std::cerr << "inProcessor ended" << std::endl;
        return true;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (post_event_type == SettingsSet) {
            return true;
        }
        if (post_event_type == SettingsGet) {
            out <<  L"{\"fftThreshold\": " << 
                driver.recv(AXI_XADC_GET_THRESHOLD) << L", " <<
                L"\"frequency\": " << 
                driver.recv(AXI_XADC_GET_FREQUENCY) << L"}";
            return true;
        }
        if (driver.is_ready()) {
            if (blocks_num == 0) {
                out << "{\"ready\":0}";
                return true;
            }
            if (data_ready_send) {
                processing_mutex.lock();
                data_ready_send = false;
                const int slice_beg = std::min(block_size, std::max(post_slice_beg, 0));
                const int slice_end = std::max(slice_beg, std::min(post_slice_end, block_size));

                auto out_delays = std::bind(&WebClientRequest::out_ary<data_type>, this, delays.begin(), delays.end());
                
                auto data_0 = std::bind(&WebClientRequest::out_ary<data_type>, this, data.begin() + 0*block_size + slice_beg, data.begin() + 0*block_size + slice_end);
                auto data_1 = std::bind(&WebClientRequest::out_ary<data_type>, this, data.begin() + 1*block_size + slice_beg, data.begin() + 1*block_size + slice_end);
                auto data_2 = std::bind(&WebClientRequest::out_ary<data_type>, this, data.begin() + 2*block_size + slice_beg, data.begin() + 2*block_size + slice_end);

                auto hilbert_0 = std::bind(&WebClientRequest::out_ary<hilbert_type>, this, hilbert_result.begin() + 0*block_size + slice_beg, hilbert_result.begin() + 0*block_size + slice_end);
                auto hilbert_1 = std::bind(&WebClientRequest::out_ary<hilbert_type>, this, hilbert_result.begin() + 1*block_size + slice_beg, hilbert_result.begin() + 1*block_size + slice_end);
                auto hilbert_2 = std::bind(&WebClientRequest::out_ary<hilbert_type>, this, hilbert_result.begin() + 2*block_size + slice_beg, hilbert_result.begin() + 2*block_size + slice_end);

                auto fourier_0 = std::bind(&WebClientRequest::out_ary<fourier_type>, this, fourier_result.begin() + 0*block_size + slice_beg, fourier_result.begin() + 0*block_size + slice_end);
                auto fourier_1 = std::bind(&WebClientRequest::out_ary<fourier_type>, this, fourier_result.begin() + 1*block_size + slice_beg, fourier_result.begin() + 1*block_size + slice_end);
                auto fourier_2 = std::bind(&WebClientRequest::out_ary<fourier_type>, this, fourier_result.begin() + 2*block_size + slice_beg, fourier_result.begin() + 2*block_size + slice_end);

                auto msg_bind = js_obj({"delays", "data", "hilbert", "fourier"}, {
                    out_delays,
                    js_ary({data_0, data_1, data_2}),
                    js_ary({hilbert_0, hilbert_1, hilbert_2}),
                    js_ary({fourier_0, fourier_1, fourier_2})
                });
                msg_bind();
                processing_mutex.unlock();
            }
        }
        return true;
    }

    template <class T>
    void out_ary(const typename std::vector<T>::iterator& data_begin, const typename std::vector<T>::iterator& data_end) {
        out << "[";
        for (auto it = data_begin; it != data_end; ++it) {
            out << *it << (std::next(it) == data_end ? "" : ","); 
        }
        out << "]";
    }

    template <class T>
    void out_indexed_ary(const typename std::vector<T>::iterator& data_begin, const typename std::vector<T>::iterator& data_end) {
        int i = 0;
        out << "[";
        for (auto it = data_begin; it != data_end; ++it, ++i) {
            out << '[' << i << ',' << *it << (std::next(it) == data_end ? "]" : "],"); 
        }
        out << "]";
    }

    // see js_obj
    std::function<void()> js_ary(const std::vector<std::function<void()>>& fs) {
        return std::bind(&WebClientRequest::js_ary_impl, this, fs);
    }

    // Usage:
    // js_obj({key_1, key_2, ..., key_n}, {value_1, value_2, ..., value_n})
    // where key_i are convertible to std::string, value_i are objects of type std::function<void()>
    // e.g.
    // 1.
    //     void value(int k) {
    //         out << k;
    //     }
    //     std::function<void()> f1 = std::bind(value, 10)
    //     std::function<void()> f2 = std::bind(value, 20)
    //     std::function<void()> obj_bind = js_obj({"key_1", "key_2"}, {f1, f2})
    //
    // on call operator() of obj_bind get {"key_1":10,"key_2":20} in out
    //
    // 2.
    //     std::function<void()> f = std::bind(value, 10)
    //     std::function<void()> array_of_values = js_ary({f, f, f})
    //     std::function<void()> obj_bind = js_obj({"key"}, array_of_values)
    //
    // obj_bind() ==> {"key":[10,10,10]}
    // js_ary({obj_bind, array_of_values, f})() ==> [{"key":[10,10,10]}, [10,10,10], 10]
    std::function<void()> js_obj(const std::vector<std::string>& keys, const std::vector<std::function<void()>>& values) {
        return std::bind(&WebClientRequest::js_obj_impl, this, keys, values);
    }
private:
    void js_ary_impl(const std::vector<std::function<void()>>& fs) {
        out << "[";
        for (unsigned i = 0; i < fs.size(); i++) {
            fs[i]();
            out << (i < fs.size() - 1 ? "," : "");
        }
        out << "]";
    }

    void js_obj_impl(const std::vector<std::string>& keys, const std::vector<std::function<void()>>& values) {
        out << "{";
        for (unsigned i = 0; i < keys.size(); i++) {
            out << '"' << keys[i].c_str() << "\":";
            values[i]();
            out << (i < keys.size() - 1 ? "," : "");
        }
        out << "}";
    }
};

int main(int argc, char** argv)
{
    if (!driver.init(DEVICE_NAME)) {
        return 0;
    }
    Fastcgipp::Manager<WebClientRequest> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "1026");
    manager.start();
    manager.join();
    return 0;
}
