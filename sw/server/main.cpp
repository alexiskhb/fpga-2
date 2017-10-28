#include <iostream>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <vector>
#include <random>

#include "../driver/ioctl_commands.h"

#include <fastcgi++/request.hpp>
#include <fastcgi++/manager.hpp>

std::random_device rd;

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
        using Fastcgipp::Encoding;

        out <<  L"Content-Type: text/html\n\n";
        out <<  std::to_wstring(rd());
        // out <<  L"<form method=\"post\"> <input type=\"text\" name=\"abc\"> <input type=\"submit\"></form>";
        // for (const auto& post: environment().posts) {
            // out << L"<b>" << Encoding::HTML << post.first << Encoding::NONE
                // << L":</b>" << Encoding::HTML << post.second
                // << Encoding::NONE << L"<br/>";
            // ioctl();
        // }
        return true;
    }
};

int main(int argc, char** argv)
{
    Fastcgipp::Manager<Modem> manager;
    manager.setupSignals();
    manager.listen("127.0.0.1", argc > 1 ? argv[1] : "8000");
    manager.start();
    manager.join();
}
