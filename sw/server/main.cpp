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
#include <functional>
#include <random>

#include "processing.h"
#include "pinger.h"
#include "../driver/ioctl_commands.h"
#include "json/json.hpp"

#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>

#define DEVICE_NAME "/dev/ham"

class Driver 
{
public:
    void send(int cmd, int* data)
    {
        // ioctl(fd, cmd, reinterpret_cast<char*>(data));
    }

    int recv(int cmd, std::vector<data_type>& out_data) 
    {
        int blocks_num = 3;
        int block_size = 1024;
        int buf_len = block_size*blocks_num;
        data_type buf[buf_len];
        int result = read(ham_driver, buf, buf_len * sizeof(data_type));
        for (int i = 0; i < buf_len; ++i) {
            if ((buf[i] & 0x00001000) == 0x00001000) {
                buf[i] = ~(buf[i] ^ 0x00001000) + 1;
            }
        }

        out_data.resize(buf_len);

        for (int i = 0; i < buf_len; i += blocks_num) {
            out_data[0*block_size + i/blocks_num] = buf[i];
            out_data[1*block_size + i/blocks_num] = buf[i + 1];
            out_data[2*block_size + i/blocks_num] = buf[i + 2];
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
        return true;
    }
private:
    int ham_driver;
};

Driver driver;

class WebClientRequest: public Fastcgipp::Request<wchar_t>
{
public:
    using json = nlohmann::json;

    WebClientRequest() : Fastcgipp::Request<wchar_t>(5*1024)
    {}
private:
    double post_d1 = 0, post_d2 = 0, post_d3 = 0, post_d4 = 0, post_threshold = 0.5;
    int post_slice_beg = 0, post_slice_end = 250, post_frequency = 20000;
    int post_pulse_len = 1, post_amplitude = 1000, post_sample_rate = 20000, post_is_simulator_test = 0;
private:
    template <class T>
    using var_json_mapper = std::vector<std::pair<std::reference_wrapper<T>, std::string>>;

    template <class T>
    void read_json(const json& post, var_json_mapper<T>& map) 
    {
        for (auto& p: map) {
            try {
                p.first.get() = post.at(p.second);
            } catch (const json::exception& e) {
                std::cerr << e.what() << std::endl;
            }
        }
    }

    bool inProcessor()
    {
        var_json_mapper<int> int_post_data = {
            {post_slice_beg, "sliceBeg"},
            {post_is_simulator_test, "isSimulatorTest"},
            {post_slice_beg, "sliceBeg"},
            {post_slice_end, "sliceEnd"},
            {post_frequency, "frequency"},
            {post_pulse_len, "pulseLen"},
            {post_amplitude, "amplitude"},
            {post_sample_rate, "sampleRate"},
        };
        var_json_mapper<double> double_post_data = {
            {post_d1, "d1"},
            {post_d2, "d2"},
            {post_d3, "d3"},
            {post_d4, "d4"},
            {post_threshold, "threshold"},
        };
        json post = json::parse(environment().postBuffer().begin(), environment().postBuffer().end());
        std::cout << post << std::endl;
        read_json(post, int_post_data);
        read_json(post, double_post_data);
        return true;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            std::vector<data_type> data;
            std::vector<fourier_type> fourier_result;
            std::vector<hilbert_type> hilbert_result;
            int blocks_num;
            if (post_is_simulator_test) {
                blocks_num = 3;
                data = Pinger{post_frequency, post_pulse_len, post_amplitude, post_sample_rate}.generate({post_d1, post_d2, post_d3});
            } else {
                blocks_num = driver.recv(0, data);
            }
            const int block_size = data.size()/blocks_num;

            std::vector<data_type> delays(blocks_num);
            process_ping_guilbert(data.data(), blocks_num, block_size, delays.data(), post_threshold, hilbert_result, fourier_result);

            const int slice_beg = std::min(block_size, std::max(post_slice_beg, 0));
            const int slice_end = std::max(slice_beg, std::min(post_slice_end, block_size));

            auto out_delays = std::bind(&WebClientRequest::out_ary<data_type>, this, delays.begin(), delays.end());
            
            auto data_0 = std::bind(&WebClientRequest::out_indexed_ary<data_type>, this, data.begin() + 0*block_size + slice_beg, data.begin() + 0*block_size + slice_end);
            auto data_1 = std::bind(&WebClientRequest::out_indexed_ary<data_type>, this, data.begin() + 1*block_size + slice_beg, data.begin() + 1*block_size + slice_end);
            auto data_2 = std::bind(&WebClientRequest::out_indexed_ary<data_type>, this, data.begin() + 2*block_size + slice_beg, data.begin() + 2*block_size + slice_end);

            auto hilbert_0 = std::bind(&WebClientRequest::out_indexed_ary<hilbert_type>, this, hilbert_result.begin() + 0*block_size + slice_beg, hilbert_result.begin() + 0*block_size + slice_end);
            auto hilbert_1 = std::bind(&WebClientRequest::out_indexed_ary<hilbert_type>, this, hilbert_result.begin() + 1*block_size + slice_beg, hilbert_result.begin() + 1*block_size + slice_end);
            auto hilbert_2 = std::bind(&WebClientRequest::out_indexed_ary<hilbert_type>, this, hilbert_result.begin() + 2*block_size + slice_beg, hilbert_result.begin() + 2*block_size + slice_end);

            auto fourier_0 = std::bind(&WebClientRequest::out_indexed_ary<fourier_type>, this, fourier_result.begin() + 0*block_size + slice_beg, fourier_result.begin() + 0*block_size + slice_end);
            auto fourier_1 = std::bind(&WebClientRequest::out_indexed_ary<fourier_type>, this, fourier_result.begin() + 1*block_size + slice_beg, fourier_result.begin() + 1*block_size + slice_end);
            auto fourier_2 = std::bind(&WebClientRequest::out_indexed_ary<fourier_type>, this, fourier_result.begin() + 2*block_size + slice_beg, fourier_result.begin() + 2*block_size + slice_end);

            auto msg_bind = js_obj({"delays", "data", "hilbert", "fourier"}, {
                out_delays,
                js_ary({data_0, data_1, data_2}),
                js_ary({hilbert_0, hilbert_1, hilbert_2}),
                js_ary({fourier_0, fourier_1, fourier_2})
            });

            msg_bind();
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
    driver.init(DEVICE_NAME);
    Fastcgipp::Manager<WebClientRequest> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
    return 0;
}
