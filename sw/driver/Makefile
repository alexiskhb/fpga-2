KERNEL_LOCATION=~/src/linux-socfpga-socfpga-4.6
ARMMAKE=make ARCH=arm SUBARCH=arm CROSS_COMPILE=/usr/bin/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

ccflags-y := -std=gnu99 -Wno-declaration-after-statement

TARGET = ham_drv
obj-m := $(TARGET).o

all:
	$(ARMMAKE) -C $(KERNEL_LOCATION) M=$(PWD) modules

clean:
	$(ARMMAKE) -C $(KERNEL_LOCATION) M=$(PWD) clean
