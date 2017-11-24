#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <string>
#include <random>

#include "../driver/ioctl_commands.h"

#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>

using namespace std;

int fd;

bool init_drv()
{
    fd = open("/dev/ham", O_RDWR);
    if (fd < 0) {
        cerr << "failed open ham device" << endl;
        return false;
    }
    return true;
}

class Modem: public Fastcgipp::Request<wchar_t>
{
public:
    Modem() : Fastcgipp::Request<wchar_t>(5*1024) 
    {}
private:
    random_device rd;
    int data[4];
    enum class Event {
    };

    bool inProcessor() 
    {
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
                    k *= 10;
                    k += *l - '0';
                    l++;
                }
                st = l;
                cout << k << ' ';
                cout.flush();
                data[i] = k;
            }
            ioctl(fd, IOCTL_SEND_4_NUMBERS, reinterpret_cast<char*>(data));
            cout << endl;
        }
        return true;
    }

    bool response()
    {
        int adc_value = 0;
       // ioctl(fd, IOCTL_GET_ADC_VALUE, &adc_value);

        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        out <<  std::to_wstring(rd()%20);
        return true;
    }
};

int main(int argc, char** argv)
{
    if (!init_drv()) {
//        return 1;
    }
    Fastcgipp::Manager<Modem> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
}
