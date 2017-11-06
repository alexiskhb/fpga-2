#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <string>

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
    enum class Event {
    };

    bool response()
    {
        int adc_value = 0;
        ioctl(fd, IOCTL_GET_ADC_VALUE, &adc_value);
        using Fastcgipp::Encoding;
        out <<  L"Content-Type: text/html\n\n";
        out <<  std::to_wstring(adc_value);
        return true;
    }
};

int main(int argc, char** argv)
{
    if (!init_drv()) {
        return 1;
    }
    Fastcgipp::Manager<Modem> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
}
