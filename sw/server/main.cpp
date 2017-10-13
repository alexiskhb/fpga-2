#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>

#include "../driver/ioctl_commands.h"

#define DEVICE_NAME                 "ham"

class Modem: public Fastcgipp::Request<wchar_t>
{
public:
    Modem() : Fastcgipp::Request<wchar_t>(1024) 
    {}
private:
    enum class Event {
        OFF_CLICKED = 0,
        ON_CLICKED = 1
    };

    bool response()
    {

        return true;
    }
};

int main() 
{
    Fastcgipp::Manager<Modem> manager;
    manager.setupSignals();
    manager.listen();
    manager.start();
    manager.join();
}
