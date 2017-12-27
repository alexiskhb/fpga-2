#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
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
    Pinger(int freq/*kHz*/, int pulse_len/*ms*/, int amplitude, int detalization) : 
        freq(freq), pulse_len(pulse_len), detl(detalization), ampl(amplitude)
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
    int freq, pulse_len, detl, ampl, periods, block_size;
    float delta;
    std::vector<datatype> data;
};

class Driver 
{
public:
    void send(int cmd, int* data)
    {
        // ioctl(fd, cmd, reinterpret_cast<char*>(data));
    }

    int recv(int cmd, const std::vector<float>& distances, std::vector<ushort>& out_data) 
    {
        // out_data = pinger.generate(distances);
        return distances.size();
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
    float d1 = 0, d2 = 0, d3 = 0, d4 = 0, threshold = 0.5;
    int slice_beg = 0, slice_end = 250, frequency = 20, pulse_len = 1, detalization = 30;
private:
    bool inProcessor()
    {
        using namespace std;
        string s(environment().postBuffer().begin(), environment().postBuffer().end());
        std::stringstream ss(s);
        ss >> d1 >> d2 >> d3 >> d4 >> slice_beg >> slice_end >> threshold >> frequency >> pulse_len >> detalization;
        std::cout << "POST:>/" << s << "/<" << std::endl;
        return true;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            std::vector<uint16_t> data = Pinger{frequency, pulse_len, 100, detalization}.generate({d1, d2, d3, d4});
            std::vector<std::pair<short, short>> spectra;
            unsigned short delays[4];
            int blocks_num = 4;
            int block_size = data.size()/blocks_num;
            process_ping_guilbert(data.data(), blocks_num, block_size, delays, threshold, spectra);
            out << delays[0] << ';' << delays[1] << ';' << delays[2] << ';' << delays[3] << "|";
            int cycle_slice_beg = std::max(slice_beg, 0);
            int cycle_slice_end = std::min(slice_end, block_size);
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
                    out << '[' << i << ',' << spectra[k*block_size + i].first << "],"; 
                }
                out << '[' << cycle_slice_end - 1 << ',' << spectra[k*block_size + cycle_slice_end - 1].first << "]],[";

                for (int i = cycle_slice_beg; i < cycle_slice_end - 1; ++i) {
                    out << '[' << i << ',' << spectra[k*block_size + i].second << "],"; 
                }
                out << '[' << cycle_slice_end - 1 << ',' << spectra[k*block_size + cycle_slice_end - 1].second << (k < blocks_num - 1 ? "]]];" : "]]]");
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
