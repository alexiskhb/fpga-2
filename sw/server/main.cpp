#define _USE_MATH_DEFINES
#include <cerrno>
#include <chrono>
#include <cmath>
#include <condition_variable>
#include <cstring>
#include <ctime>
#include <fcntl.h>
#include <fstream>
#include <functional>
#include <iostream>
#include <limits>
#include <linux/types.h>
#include <mutex>
#include <netinet/in.h>
#include <random>
#include <signal.h>
#include <sstream>
#include <string>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <thread>
#include <unistd.h>
#include <vector>

#include "processing.h"
#include "pinger.h"
#include "../driver/ioctl_commands.h"
#include "json/json.hpp"

#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>


/* IOCTL defines */
#define AXI_XADC_IOCTL_BASE                             'W'
#define AXI_HANDLE_INTERRUPT                            _IO(AXI_XADC_IOCTL_BASE, 0)
#define AXI_XADC_SET_PID                                _IO(AXI_XADC_IOCTL_BASE, 1)
#define AXI_XADC_DMA_CONFIG                             _IO(AXI_XADC_IOCTL_BASE, 2)
#define AXI_XADC_DMA_START                              _IO(AXI_XADC_IOCTL_BASE, 3)
#define AXI_XADC_DMA_STOP                               _IO(AXI_XADC_IOCTL_BASE, 4)
#define AXI_XADC_SET_THRESHOLD                          _IO(AXI_XADC_IOCTL_BASE, 5)
#define AXI_XADC_SET_FREQUENCY                          _IO(AXI_XADC_IOCTL_BASE, 6)
#define AXI_XADC_GET_THRESHOLD                          _IO(AXI_XADC_IOCTL_BASE, 7)
#define AXI_XADC_GET_FREQUENCY                          _IO(AXI_XADC_IOCTL_BASE, 8)
#define AXI_XADC_REARM                                  _IO(AXI_XADC_IOCTL_BASE, 9)

#define SIG_DATA_READY                  55
#define FIFO_SIZE                       8192

#define MAX_LOG_CNT (500)
int log_cntr = 0;

using namespace std;

template <typename Duration, typename Function>
void timer(Duration const & d, Function const & f)
{
    std::thread([d, f](){
        std::this_thread::sleep_for(d);
        f();
    }).detach();
}

#pragma pack(push,1)
typedef struct {
    int preamble;
    unsigned char beacon_type;
    unsigned short arrival_time[4];
} dsp_data;
#pragma pack(pop)

namespace {
    int fd;
    std::mutex mtx_dev;

    unsigned short *draw_data_ptr;
    unsigned short draw_data[FIFO_SIZE / 2];

    unsigned char *buffer;

    std::condition_variable cv_sig;
    std::mutex mtx_sig;
    struct sigaction sig;

    sig_atomic_t data_rcvd_flag = 0;
    sig_atomic_t delays_ready = 0;
    sig_atomic_t delays_ready_send = 0;
    vector<char> data_rcvd;
    float threshold = 0.14;

    static union {
        dsp_data data_out;
        unsigned char data_buf[sizeof(dsp_data)];
    };

    int sock, listener;
    struct sockaddr_in addr;

    std::mutex json_mutex;
    int block_size = 1024;
};

int measure_time()
{
    using namespace std::chrono;
    static const high_resolution_clock::time_point t1 = high_resolution_clock::now();
    high_resolution_clock::time_point t2 = high_resolution_clock::now();
    duration<double, std::milli> time_span = t2 - t1;
    return time_span.count();
}

std::vector<data_type> data(FIFO_SIZE);
std::vector<fourier_type> fourier_result(FIFO_SIZE);
std::vector<hilbert_type> hilbert_result(FIFO_SIZE);
std::vector<data_type> delays(4);

static void handle_signal(int n, siginfo_t *info, void *unused) 
{
    std::cout << "handle_signal" << std::endl;
    data_rcvd_flag = 1;
    std::unique_lock<std::mutex> lck(mtx_sig, std::defer_lock);
    draw_data_ptr = reinterpret_cast<unsigned short *>(buffer);
    while(!lck.try_lock()){;}
    for (int i = 0; i < FIFO_SIZE / 2; i+=4) {
        data[i / 4 + 0 * FIFO_SIZE / 8] = draw_data_ptr[i + 0];
        data[i / 4 + 1 * FIFO_SIZE / 8] = draw_data_ptr[i + 1];
        data[i / 4 + 2 * FIFO_SIZE / 8] = draw_data_ptr[i + 2];
        data[i / 4 + 3 * FIFO_SIZE / 8] = draw_data_ptr[i + 3];
    }
    process_ping_guilbert(data.data(), 4, 1024, delays.data(), threshold, hilbert_result, fourier_result);
    // processing_ping_guilbert(draw_data, 4, 1024, data_out.arrival_time, threshold);
    delays_ready = 1;
    delays_ready_send = 1;
    timer(std::chrono::milliseconds(500), [](){ioctl(fd, AXI_XADC_REARM);});

}

static int init_drv()
{
    fd = open("/dev/channel0", O_RDONLY);
    if(fd < 0) {
        cerr << "captureThread :: dev open error" << endl;
        return -1;  
    }
    
    buffer = static_cast<unsigned char *>(mmap(0, FIFO_SIZE, PROT_READ, MAP_SHARED, fd, 0));

    sig.sa_sigaction = handle_signal;
    sig.sa_flags = SA_SIGINFO;
    sigaction(SIG_DATA_READY, &sig, NULL);

    if (ioctl(fd, AXI_XADC_SET_PID, getpid()) < 0) {
        cerr << "HAM device failed IOCTL_SET_PID" << endl;
        return -1;
    }
    ioctl(fd, AXI_XADC_SET_THRESHOLD, 2);
    ioctl(fd, AXI_XADC_SET_FREQUENCY, 53);

    listener = socket(AF_INET, SOCK_STREAM, 0);
    if(listener < 0)
    {
        cerr << "failed to create socket" << endl;
        return -1;
    }

    int reuse = 1;
    setsockopt(listener, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(reuse));

    addr.sin_family = AF_INET;
    addr.sin_port = htons(3425);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    if(bind(listener, (struct sockaddr *)&addr, sizeof(addr)) < 0)
    {
        cerr << "failed to bind socket" << endl;
        return -1;
    }

    listen(listener, 1);

    std::thread([](){
        int error_code;
        socklen_t error_code_size = sizeof(error_code);
        while(1) {
            sock = accept(listener, NULL, NULL);
            if(sock < 0) {   
                sleep(1);
                break;
            }
            cout << "client connected" << endl;

            std::thread([](){
                while (1) {
                    std::uint8_t command;
                    if (::recv(sock, &command, sizeof(command), 0) > 0) {
                        if (33 <= command && command <= 60) {
                            std::cout <<  "client recv command " << (int)command << std::endl;
                            ioctl(fd, AXI_XADC_SET_FREQUENCY, command);
                        }
                    }
                }
            }).detach();

            while(1) {
                std::this_thread::sleep_for(std::chrono::milliseconds(10));

                if(delays_ready_send) {
                    delays_ready_send = 0;
                    if(send(sock, data_buf, sizeof(dsp_data), 0) < 0) {
                        cout << "client disconnected" << endl;
                        close(sock);
                        break;
                    }
                }
                getsockopt(sock, SOL_SOCKET, SO_ERROR, &error_code, &error_code_size);
                if(error_code) {
                    cout << "client disconnected" << endl;
                    close(sock);
                    break;       
                }
            }
        }
    }).detach();

    ioctl(fd, AXI_XADC_DMA_START);
    return 0;
}

int recv(int cmd) {
    return ioctl(fd, cmd);
}

void send(int cmd) {
    ioctl(fd, cmd);
}

void send(int cmd, unsigned long arg) {
    ioctl(fd, cmd, arg);
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
            send(post_event_type == StartDMA ? AXI_XADC_DMA_START : AXI_XADC_DMA_STOP);
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
                send(AXI_XADC_SET_THRESHOLD, post_fft_threshold);
                send(AXI_XADC_SET_FREQUENCY, post_frequency);
            }
            mtx_sig.lock();
            threshold = post_hilbert_threshold;
            mtx_sig.unlock();
        }
        std::cerr << "inProcessor ended" << std::endl;
        return true;
    }

    bool response()
    {
        std::unique_lock<std::mutex> lck(mtx_dev, std::defer_lock);
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (post_event_type == SettingsSet) {
            return true;
        }
        if (post_event_type == SettingsGet) {
            out <<  L"{\"fftThreshold\": " << 
                recv(AXI_XADC_GET_THRESHOLD) << L", " <<
                L"\"frequency\": " << 
                recv(AXI_XADC_GET_FREQUENCY) << L"}";
            return true;
        }
        if (data_rcvd_flag && delays_ready) {
            if (lck.try_lock()) {
                data_rcvd_flag = 0;
                delays_ready = 0;
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
            }
        }
        if (delays_ready) {
            out << "{\"ready\":000}";
        } else if (data_rcvd_flag) {
            out << "{\"ready\":00}";
        } else {
            out << "{\"ready\":0}";
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

Fastcgipp::Manager<WebClientRequest> manager;

int main()
{
    init_drv();

    manager.setupSignals();
    manager.listen("127.0.0.1", "1026");
    manager.start();
    manager.join();

    cout << "axi_xadc_app :: Data Capture Thread Terminated" << endl;
    return 0;
  }


