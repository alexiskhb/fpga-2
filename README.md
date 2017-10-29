# fpga-2
Используемая плата: Altera DE0-Nano-SoC Board(Terasic), [документация](http://www.terasic.com.tw/attachment/archive/941/DE0-Nano-SoC_User_manual.pdf)

Версия [ядра](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=163&No=941&PartNo=4) - 3.13

Используемый кросс компилятор для сборки [arm-linux-gnueabihf](https://releases.linaro.org/components/toolchain/binaries/5.4-2017.05/arm-linux-gnueabihf/) 5-ой версии 

Адрес для подключения по SSH: **192.168.48.27 login:root pass:root**

Подключение через screen: **sudo screen /dev/ttyUSB0 115200**

Для прошивки FPGA использовать файлы с расширением *.jic 

Драйвера складывать в папку */home/*

Используемый [style guide](https://github.com/msporyshev/fefuauv-styleguide)

В случае, когда uboot сломался подключаемся через screen и выполняем:

setenv fpga2sdram_handoff 0

run bridge_enable_handoff

run mmcboot
