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

class Driver 
{
public:
    void send(int cmd, int* data) 
    {
        // ioctl(fd, cmd, reinterpret_cast<char*>(data));
    }

    int recv(int cmd, std::vector<ushort>& out_data) 
    {
        int limit = std::numeric_limits<ushort>::max()/1000;
        int blocks_num = 5;
        int k = 1024*2;
        out_data.resize(k*blocks_num);
        for (int i = 0; i < k; i++) {
            out_data[0*k + i] =   limit*sin(     (i + std::time(0))/10.0) +   limit;
            out_data[1*k + i] = 2*limit*sin( 250*(i + std::time(0))/10.0) + 2*limit;
            out_data[2*k + i] = 3*limit*sin( 500*(i + std::time(0))/10.0) + 3*limit;
            out_data[3*k + i] = 4*limit*sin(1000*(i + std::time(0))/10.0) + 4*limit;
            out_data[(blocks_num - 1)*k + i] = out_data[0*k + i] + out_data[1*k + i] + out_data[2*k + i] + out_data[3*k + i];
        }
        return blocks_num;
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
            // driver.send(IOCTL_SEND_4_NUMBERS, data);
        }
        return true;
    }

    bool response()
    {
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            std::vector<unsigned short> data;
            std::vector<short> spectra;
            unsigned short delays[4];
            float threshold = 0.14;
            int blocks_num = driver.recv(0, data);
            threshold = 0.95;
            process_ping_guilbert(data.data(), 4, 1024, delays, threshold, spectra);
            out << delays[0] << ';' << delays[1] << ';' << delays[2] << ';' << delays[3] << "|";
            int slice_size = 64, block_size = data.size()/blocks_num;
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
                    out << '[' << i << ',' << spectra[k*block_size + i] << "],"; 
                }
                out << '[' << slice_size - 1 << ',' << spectra[k*block_size + slice_size - 1] << (k < blocks_num - 1 ? "]]];" : "]]]");
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
