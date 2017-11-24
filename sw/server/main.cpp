#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <string>
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
        ioctl(fd, cmd, reinterpret_cast<char*>(data));
    }

    void recv(int cmd, std::vector<unsigned short>& out_data) //8192 
    {
        int k = 8192/4;
        out_data.resize(k*4);
        for (int i = 0; i < k; i++) {
            out_data[0*k + i] = rand();
            out_data[1*k + i] = rand();
            out_data[2*k + i] = rand();
            out_data[3*k + i] = rand();
        }
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
            return false;
        }
        return true;
    }
private:
    int fd;
};

class WebClientRequest: public Fastcgipp::Request<wchar_t>
{
public:
    WebClientRequest() : Fastcgipp::Request<wchar_t>(5*1024) 
    {
        // Wrong: new request is created on every request
        // driver.init(DEVICE_NAME);
    }
    
private:
    int data[4];
    Driver driver;
    
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
            driver.send(IOCTL_SEND_4_NUMBERS, data);
        }
        return true;
    }

    bool response()
    {
        int adc_value = 0;
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        if (driver.is_ready()) {
            std::vector<unsigned short> data;
            driver.recv(0, data);
            unsigned short delays[4];
            float threshold = 0.14;
            process_ping_guilbert(data.data(), 4, 1024, delays, threshold);
            out << delays[0] << ';' << delays[1] << ';' << delays[2] << ';' << delays[3];
        }
        out <<  std::to_wstring(0);
        return true;
    }
};

int main(int argc, char** argv)
{
    Fastcgipp::Manager<WebClientRequest> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
}
