**nginx.conf**
Процессы nginx будут работать с правами пользователя, указанного в поле user;
http->server->listen 80 -- порт, используемый http по умолчанию;
http->server->root указывает на директорию с index (index.html);

http->server->location /sv, fastcgi_pass 127.0.0.1:8000:
    http запрос клиента к http://xxx.xxx.xxx.xxx/sv будет передан на порт 8000, прослушиваемый fastcgi;
    Fastcgipp::Manager::listen() должен слушать этот же порт;

https://releases.linaro.org/components/toolchain/binaries/latest/arm-linux-gnueabihf/
на момент написания памятки используется gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf

**CMakeLists.txt**
make debug_x64 -- для отладки
make release -- для сборки предназначенного для платы бинарника
set(triple /usr/bin/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-) -- gcc, g++ и ld кросс-компилятора имеют префикс $(triple)
(https://clang.llvm.org/docs/CrossCompilation.html если интересно, что значит термин triple)
so-шники и проч. лежат в lib

**fftw**
http://www.fftw.org/
Поддерживает кросс-компиляцию: http://www.fftw.org/fftw3_doc/Installation-on-Unix.html
./configure --host=arm-linux-gnueabihf "CC=path/to/triple-gcc -march=armv7-a -mfloat-abi=softfp"
mkdir build && cd build && cmake .. && make генерирует libfftw3.a

**fastcgi++**
исходники: https://github.com/eddic/fastcgipp
документация: https://isatec.ca/fastcgipp/
при компиляции генерит нужные so-шники
