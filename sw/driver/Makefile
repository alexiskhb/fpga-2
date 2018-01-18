KERNEL_LOCATION=~/src/linux-socfpga-socfpga-3.13-rel14.0
ARMMAKE=make ARCH=arm SUBARCH=arm CROSS_COMPILE=/usr/bin/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

ccflags-y := -Wno-declaration-after-statement

TARGET = ham_drv
obj-m := $(TARGET).o

all:
	$(ARMMAKE) -C $(KERNEL_LOCATION) M=$(PWD) modules

clean:
	$(ARMMAKE) -C $(KERNEL_LOCATION) M=$(PWD) clean
