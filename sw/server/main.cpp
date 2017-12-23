#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
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

int upperpow2(int k) {
    int result = 1;
    while (result < k) {
        result <<= 1;
    }
    return result;
}

class Pinger {
public:
    using datatype = uint16_t;
    Pinger(int x, int y, int z, int freq/*kHz*/, int pulse_len/*ms*/, int amplitude = 100, int detalization = 30) : 
        x(x), y(y), z(z), freq(freq), pulse_len(pulse_len), detl(detalization), ampl(amplitude)
    {
        this->delta = 1.0 / (1000 * freq * detl);
        this->periods = pulse_len * freq;
        this->block_size = upperpow2(periods*detl);
        std::cout << 
            "freq: " << freq <<
            "\ndelta: " << delta <<
            "\ndetalization: " << detalization << 
            "\nperiods: " << periods <<
            "\nblock size: " << block_size << std::endl;
    }

    std::vector<datatype> generate(std::vector<float> distances/*meters*/) 
    {
        float min_dist = distances.front();
        for (int d: distances) {
            if (d < min_dist) {
                min_dist = d;
            }
        }
        int blocks_num = distances.size();
        std::vector<datatype> result(block_size * blocks_num);
        m_generate_data(block_size, delta);
        for (int i = 0; i < blocks_num; i++) {
            m_generate_impl(result.begin() + block_size*i, distances[i] - min_dist);
        }
        return result;
    }
public:
    void m_generate_impl(const std::vector<datatype>::iterator begin, float dist)
    {
        float speed_of_sound = 1468.5;
        int shift = (dist/delta)/speed_of_sound;
        std::cout << shift << std::endl;
        std::fill(begin, begin + shift, 0);
        std::copy(data.begin(), data.end() - shift, begin + shift);
    }

    void m_generate_data(int block_size, float delta)
    {
        data.resize(block_size);
        for (int i = 0; i < block_size; i++) {
            float t = delta*i*1000*1000;
            data[i] = ampl*sin(t) + ampl + 1;
        }
    }
    int x, y, z, freq, pulse_len, detl, ampl, periods, block_size;
    float delta;
    std::vector<datatype> data;
};

Pinger pinger{0, 0, 0, 20, 1, 100, 50};

class Driver 
{
public:
    void send(int cmd, int* data)
    {
        // ioctl(fd, cmd, reinterpret_cast<char*>(data));
    }

    int recv(int cmd, std::vector<ushort>& out_data) 
    {
        out_data = pinger.generate({0.2, 0.08, 0.2, 0.3});
        return 4;
    }

    bool is_ready() 
    {
        return true;
    }

    bool init(const char* name) 
    {
        fd = open(name, O_RDWR);
        if (fd < 0) {
            std::cerr << "failed open ham device" << std::endl;
            // return false;
        }
        return true;
    }
private:
    int fd;
};

Driver driver;

class WebClientRequest: public Fastcgipp::Request<wchar_t>
{
public:
    WebClientRequest() : Fastcgipp::Request<wchar_t>(5*1024)
    {}
private:
    unsigned short data[4];
private:
    bool inProcessor()
    {
        using namespace std;
        string s(environment().postBuffer().begin(), environment().postBuffer().end());
        if (s.size() > 0) {
            auto st = s.begin();
            for (int i = 0; i < 4; i++) {
                auto l = find(st, s.end(), '=');
                if (l == s.end()) {
                    throw runtime_error("4-numbers-query is invalid");
                }
                int k = 0;
                while (l != s.end() && *l != '&') {
                    k = 10*k + *l - '0';
                    l++;
                }
                st = l;
                cout << k << ' ';
                cout.flush();
                data[i] = k;
            }
            cout << endl;
        }
        return true;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            std::vector<uint16_t> data;
            std::vector<std::pair<short, short>> spectra;
            unsigned short delays[4];
            float threshold = 0.14;
            int blocks_num = driver.recv(0, data);
            threshold = 0.95;
            int block_size = data.size()/blocks_num, slice_size = 256;
            process_ping_guilbert(data.data(), blocks_num, block_size, delays, threshold, spectra);
            out << delays[0] << ';' << delays[1] << ';' << delays[2] << ';' << delays[3] << "|";
            for (int k = 0; k < blocks_num; k++) {
                out << "[[";
                for (int i = 0; i < slice_size - 1; ++i) {
                    out << '[' << i << ',' << data[k*block_size + i] << "],"; 
                }
                out << '[' << slice_size - 1 << ',' << data[k*block_size + slice_size - 1] << (k < blocks_num - 1 ? "]]];" : "]]]");
            }
            out << "|";
            for (int k = 0; k < blocks_num; k++) {
                out << "[[";
                for (int i = 0; i < slice_size - 1; ++i) {
                    out << '[' << i << ',' << spectra[k*block_size + i].first << "],"; 
                }
                out << '[' << slice_size - 1 << ',' << spectra[k*block_size + slice_size - 1].first << "]],[";

                for (int i = 0; i < slice_size - 1; ++i) {
                    out << '[' << i << ',' << spectra[k*block_size + i].second << "],"; 
                }
                out << '[' << slice_size - 1 << ',' << spectra[k*block_size + slice_size - 1].second << (k < blocks_num - 1 ? "]]];" : "]]]");
            }
        }

        return true;
    }
};

int main(int argc, char** argv)
{
    // driver.init();
    Fastcgipp::Manager<WebClientRequest> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
    return 0;
}
