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
#include <fstream>
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

    int recv(int cmd, vec1d<data_type>& out_data) 
    {
        int blocks_num = 3;
        int block_size = 1024;
        int buf_len = block_size*blocks_num;
        data_type buf[buf_len];
        read(ham_driver, buf, buf_len * sizeof(data_type));
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
Pinger pinger;

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
    bool inProcessor()
    {
        json post = json::parse(environment().postBuffer().begin(), environment().postBuffer().end());
        std::cout << post << std::endl;
        try {
            post_is_simulator_test = post.at("isSimulatorTest");
            post_d1 = post.at("d1");
            post_d2 = post.at("d2");
            post_d3 = post.at("d3");
            post_d4 = post.at("d4");
            post_slice_beg = post.at("sliceBeg");
            post_slice_end = post.at("sliceEnd");
            post_threshold = post.at("threshold");
            post_frequency = post.at("frequency");
            post_pulse_len = post.at("pulseLen");
            post_amplitude = post.at("amplitude");
            post_sample_rate = post.at("sampleRate");
        } catch (json::exception e) {
            std::cerr << e.what() << std::endl;
        }
        return true;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            vec2d<data_type> data;
            vec2d<fourier_type> fourier_result;
            vec2d<hilbert_type> hilbert_result;
            if (post_is_simulator_test) {
                // pinger.set(post_frequency, post_pulse_len, post_amplitude, post_sample_rate);
                data = pinger.generate({post_d1, post_d2, post_d3});
            } else {
                data = vec2d<data_type>(3, vec1d<data_type>(256));
            }
            const int blocks_num = data.size();
            const int block_size = data.front().size();

            vec1d<data_type> delays(blocks_num);
            process_ping_guilbert(data, post_threshold, delays, hilbert_result, fourier_result);

            const int slice_beg = std::min(block_size, std::max(post_slice_beg, 0));
            const int slice_end = std::max(slice_beg, std::min(post_slice_end, block_size));

            auto out_delays = std::bind(&WebClientRequest::out_ary<data_type>, this, delays.begin(), delays.end());
            
            auto data_0 = std::bind(&WebClientRequest::out_indexed_ary<data_type>, this, data[0].begin() + slice_beg, data[0].begin() + slice_end);
            auto data_1 = std::bind(&WebClientRequest::out_indexed_ary<data_type>, this, data[1].begin() + slice_beg, data[1].begin() + slice_end);
            auto data_2 = std::bind(&WebClientRequest::out_indexed_ary<data_type>, this, data[2].begin() + slice_beg, data[2].begin() + slice_end);

            auto hilbert_0 = std::bind(&WebClientRequest::out_indexed_ary<hilbert_type>, this, hilbert_result[0].begin() + slice_beg, hilbert_result[0].begin() + slice_end);
            auto hilbert_1 = std::bind(&WebClientRequest::out_indexed_ary<hilbert_type>, this, hilbert_result[1].begin() + slice_beg, hilbert_result[1].begin() + slice_end);
            auto hilbert_2 = std::bind(&WebClientRequest::out_indexed_ary<hilbert_type>, this, hilbert_result[2].begin() + slice_beg, hilbert_result[2].begin() + slice_end);

            auto fourier_0 = std::bind(&WebClientRequest::out_indexed_ary<fourier_type>, this, fourier_result[0].begin() + slice_beg, fourier_result[0].begin() + slice_end);
            auto fourier_1 = std::bind(&WebClientRequest::out_indexed_ary<fourier_type>, this, fourier_result[1].begin() + slice_beg, fourier_result[1].begin() + slice_end);
            auto fourier_2 = std::bind(&WebClientRequest::out_indexed_ary<fourier_type>, this, fourier_result[2].begin() + slice_beg, fourier_result[2].begin() + slice_end);

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
    void out_ary(const typename vec1d<T>::iterator& data_begin, const typename vec1d<T>::iterator& data_end) {
        out << "[";
        for (auto it = data_begin; it != data_end; ++it) {
            out << *it << (std::next(it) == data_end ? "" : ","); 
        }
        out << "]";
    }

    template <class T>
    void out_indexed_ary(const typename vec1d<T>::iterator& data_begin, const typename vec1d<T>::iterator& data_end) {
        int i = 0;
        out << "[";
        for (auto it = data_begin; it != data_end; ++it, ++i) {
            out << '[' << i << ',' << *it << (std::next(it) == data_end ? "]" : "],"); 
        }
        out << "]";
    }

    // see js_obj
    std::function<void()> js_ary(const vec1d<std::function<void()>>& fs) {
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
    std::function<void()> js_obj(const vec1d<std::string>& keys, const vec1d<std::function<void()>>& values) {
        return std::bind(&WebClientRequest::js_obj_impl, this, keys, values);
    }
private:
    void js_ary_impl(const vec1d<std::function<void()>>& fs) {
        out << "[";
        for (unsigned i = 0; i < fs.size(); i++) {
            fs[i]();
            out << (i < fs.size() - 1 ? "," : "");
        }
        out << "]";
    }

    void js_obj_impl(const vec1d<std::string>& keys, const vec1d<std::function<void()>>& values) {
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
    std::ifstream json_data_file("data.json");
    // std::cout << std::setw(4) << j << std::endl;
    pinger.load(json_data_file);
    driver.init(DEVICE_NAME);
    Fastcgipp::Manager<WebClientRequest> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
    return 0;
}
