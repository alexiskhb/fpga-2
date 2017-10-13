#include <asm/uaccess.h>
#include <linux/cdev.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/io.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include "ioctl_commands.h"

#define DEVICE_NAME                 "ham"
#define UINPUT_BASE                 0xff200000
#define UINPUT_SIZE                 0x00070000

#define MODULE_OFFSET               (ham_drv_mem + 0x00050000)
#define SET_LEDS_OFFSET             (MODULE_OFFSET + 1 * sizeof(u32))

static void *ham_drv_mem = NULL;
static struct class *ham_drv_class  = NULL;
static struct device *ham_drv_device = NULL;

static int major_number;

static ssize_t ham_drv_write(struct file *filep, const char *buffer, size_t len, loff_t *offset){
    if (len < 2 || len > 4) {
        printk(KERN_ALERT "ham_drv: wrong length\n");
        return -EINVAL;
    }
    char message[4];
    if (copy_from_user(message, buffer, len - 1)) {
        printk(KERN_ALERT "ham_drv: copy error\n");
        return -EINVAL;
    }
    long number;
    int ret;
    if ((ret = kstrtol(message, 0, &number))) {
        return ret;
    }
    if (number < 0 || number > 255) {
        printk(KERN_ALERT "ham_drv: wrong command\n");
        return -EINVAL;
    }
    iowrite32(number, SET_LEDS_OFFSET);
    printk(KERN_INFO "ham_drv: recived %ld\n", number);
    return len;
}

static long ham_drv_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
{
    switch (cmd) {
        case IOCTL_SET_LEDS:
            iowrite32(arg, SET_LEDS_OFFSET);
            return 0;
        default:
            printk(KERN_ALERT "ham_drv: wrong ioctl command %d\n", cmd);
            return -ENOIOCTLCMD;
    }
}

static const struct file_operations ham_drv_fops = {
    .owner = THIS_MODULE,
    .write = ham_drv_write,
    .unlocked_ioctl = ham_drv_ioctl,
    .llseek = no_llseek,
};

static int __init ham_drv_init(void)
{
    int ret = 0;

    major_number = register_chrdev(0, DEVICE_NAME, &ham_drv_fops);
    if (major_number < 0) {
        printk(KERN_ALERT "ham_drv: failed to register a major number\n");
        ret = major_number;
        goto fail_register_chrdev;
    }

    ham_drv_class = class_create(THIS_MODULE, "ham_drv");
    if (IS_ERR(ham_drv_class)) {
        printk(KERN_ALERT "ham_drv: failed to register class\n");
        goto fail_create_class;
        ret = PTR_ERR(ham_drv_class);
    }

    ham_drv_device = device_create(ham_drv_class, NULL, MKDEV(major_number, 0), NULL, DEVICE_NAME);
    if (IS_ERR(ham_drv_device)) {
        printk(KERN_ALERT "ham_drv: failed to create the device\n");
        goto fail_create_device;
        ret = PTR_ERR(ham_drv_device);
    }

    if (request_mem_region(UINPUT_BASE, UINPUT_SIZE, "ham_drv") == NULL) {
        ret = -EBUSY;
        goto fail_request_mem_region;
    }

    ham_drv_mem = ioremap(UINPUT_BASE, UINPUT_SIZE);
    if (ham_drv_mem == NULL) {
        ret = -EFAULT;
        goto fail_ioremap;
    }

    iowrite32(0xff, SET_LEDS_OFFSET);
    printk(KERN_INFO "ham_drv: successfully initialized\n");
    return 0;

fail_ioremap:
    release_mem_region(UINPUT_BASE, UINPUT_SIZE);
fail_request_mem_region:
    device_destroy(ham_drv_class, MKDEV(major_number, 0));
    class_unregister(ham_drv_class);
fail_create_device:
    class_destroy(ham_drv_class);
fail_create_class:
    unregister_chrdev(major_number, DEVICE_NAME);
fail_register_chrdev:
    printk(KERN_ALERT "ham_drv: initialization failed\n");
    return ret;
}

static void __exit ham_drv_exit(void)
{
    iowrite32(0x00, SET_LEDS_OFFSET);
    release_mem_region(UINPUT_BASE, UINPUT_SIZE);
    device_destroy(ham_drv_class, MKDEV(major_number, 0));
    class_unregister(ham_drv_class);
    class_destroy(ham_drv_class);
    unregister_chrdev(major_number, DEVICE_NAME);
    return;
}

MODULE_LICENSE("Dual BSD/GPL");

module_init(ham_drv_init);
module_exit(ham_drv_exit);