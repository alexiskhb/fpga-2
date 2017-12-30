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
#include <random>

#include "processing.h"
#include "../driver/ioctl_commands.h"

#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>

#define DEVICE_NAME "/dev/ham"

const bool test_generator = false;

int upperpow2(int k) {
    int result = 1;
    while (result < k) {
        result <<= 1;
    }
    return result;
}

class Pinger {
public:
    Pinger(int freq/*Hz*/, int pulse_len/*ms*/, int amplitude, int sample_rate) : 
        freq(freq), pulse_len(pulse_len), ampl(amplitude), sample_rate(sample_rate)
    {
        this->block_size = upperpow2(pulse_len*measures_per_ms);
        std::cout << 
            "freq: " << freq <<
            "\nblock size: " << block_size << std::endl;
    }

    std::vector<data_type> generate(std::vector<double> distances/*meters*/) 
    {
        double min_dist = distances.front();
        for (int d: distances) {
            if (d < min_dist) {
                min_dist = d;
            }
        }
        int blocks_num = distances.size();
        std::vector<data_type> result(block_size * blocks_num);
        m_generate_data(block_size);
        for (int i = 0; i < blocks_num; i++) {
            m_generate_impl(result.begin() + block_size*i, distances[i] - min_dist);
        }
        return result;
    }
public:
    void m_generate_impl(const std::vector<data_type>::iterator begin, double dist)
    {
        double speed_of_sound = 1468.5;
        // I don't know why 1000000
        int shift = std::min(int(1'000'000*dist/speed_of_sound), block_size);
        std::cout << shift << std::endl;
        std::fill(begin, begin + shift, 0);
        std::copy(data.begin(), data.end() - shift, begin + shift);
    }

    void m_generate_data(int block_size)
    {
        data.resize(block_size);
        for (int t = 0; t < block_size; t++) {
            data[t] = ampl*sin((2*M_PI*t*freq)/sample_rate) + ampl + 1;
        }
    }
    const int measures_per_ms = 1000;
    int freq, pulse_len, ampl, block_size, sample_rate;
    std::vector<data_type> data;
};

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
        std::cout << result << std::endl;
        out_data.resize(buf_len);

        for (int i = 0; i < buf_len; i += blocks_num) {
            out_data[0*block_size + i/blocks_num] = buf[i];
            out_data[1*block_size + i/blocks_num] = buf[i + 1];
            out_data[2*block_size + i/blocks_num] = buf[i + 2];
        }
        std::cout << std::endl;
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
    WebClientRequest() : Fastcgipp::Request<wchar_t>(5*1024)
    {}
private:
    data_type data[4];
    double d1 = 0, d2 = 0, d3 = 0, d4 = 0, threshold = 0.5;
    int slice_beg = 0, slice_end = 250, frequency = 20000;
    int pulse_len = 1, amplitude = 1000, sample_rate = 20000;
private:
    bool inProcessor()
    {
        using namespace std;
        string s(environment().postBuffer().begin(), environment().postBuffer().end());
        std::stringstream ss(s);
        ss >> d1 >> d2 >> d3 >> d4 >> slice_beg >> slice_end >> threshold >> frequency >> pulse_len >> amplitude;
        std::cout << "POST:>/" << s << "/<" << std::endl;
        return true;
    }

    template<class T>
    typename std::enable_if<std::is_arithmetic<T>::value, std::string>::type to_json(const T& c) {
        return to_string(c);
    }

    template<class T1, class T2>
    std::string to_json(const std::pair<T1, T2>& p) {
        return "[" + std::to_string(p.first) + "," + std::to_string(p.second) + "]";
    }

    template<class T>
    std::string to_json(const std::vector<T>& c) {
        if (c.size() == 0) {
            return "[]";
        }
        std::string result = "[";
        for (const T& e: c) {
            result += to_json(e) + ",";
        }
        result.back() = ']';
        return result;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            std::vector<data_type> data, hilbert_result, fourier_result;
            int blocks_num;
            if (!test_generator) {
                blocks_num = driver.recv(0, data);
            } else {
                blocks_num = 4;
                data = Pinger{frequency, pulse_len, amplitude, sample_rate}.generate({d1, d2, d3, d4});
            }
            int block_size = data.size()/blocks_num;

            data_type delays[blocks_num];
            process_ping_guilbert(data.data(), blocks_num, block_size, delays, threshold, hilbert_result, fourier_result);
            
            // Order of output matters.
            // Don't change it
            // 0;1;2;3|[...
            for (int i = 0; i < blocks_num; i++) {
                out << delays[i] << (i < blocks_num - 1 ? ';' : '|');
            }
            int cycle_slice_beg = std::max(slice_beg, 0);
            int cycle_slice_end = std::min(slice_end, block_size);
            // Output data in JSON format:
            // [[[0,1],[2,3],...]];[[[6,7],...]];...;[[[8,9],...]]|[[[10, 11],...]],...
            //  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|^^^^^^^^^^^^^^^^^^^^
            //                 left charts                        |    right charts
            for (int k = 0; k < blocks_num; k++) {
                out << "[[";
                for (int i = cycle_slice_beg; i < cycle_slice_end - 1; ++i) {
                    out << '[' << i << ',' << data[k*block_size + i] << "],"; 
                }
                out << '[' << cycle_slice_end - 1 << ',' << data[k*block_size + cycle_slice_end - 1] << (k < blocks_num - 1 ? "]]];" : "]]]");
            }
            out << "|";
            for (int k = 0; k < blocks_num; k++) {
                out << "[[";
                for (int i = cycle_slice_beg; i < cycle_slice_end - 1; ++i) {
                    out << '[' << i << ',' << hilbert_result[k*block_size + i] << "],"; 
                }
                out << '[' << cycle_slice_end - 1 << ',' << hilbert_result[k*block_size + cycle_slice_end - 1] << "]],[";

                for (int i = cycle_slice_beg; i < cycle_slice_end - 1; ++i) {
                    out << '[' << i << ',' << fourier_result[k*block_size + i] << "],"; 
                }
                out << '[' << cycle_slice_end - 1 << ',' << fourier_result[k*block_size + cycle_slice_end - 1] << (k < blocks_num - 1 ? "]]];" : "]]]");                
            }
        }

        return true;
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
