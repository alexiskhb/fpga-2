#include <linux/cdev.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include "ioctl_commands.h"

#define DEVICE_NAME                 "ham"
#define UINPUT_BASE                 0xff200000
#define UINPUT_SIZE                 0x00070000
#define INTERRUPT_NUM               77

#define MODULE_OFFSET               (ham_drv_mem + 0x00050000)
#define GET_ADC_OFFSET              (MODULE_OFFSET + 1 * sizeof(u32))

static void *ham_drv_mem = NULL;
static struct class *ham_drv_class  = NULL;
static struct device *ham_drv_device = NULL;

static int major_number;

static int adc_value = 0;

static long ham_drv_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
{
    switch (cmd) {
        case IOCTL_GET_ADC_VALUE:
            return put_user(adc_value, (int __user *)(arg));
        default:
            printk(KERN_ALERT "ham_drv: wrong ioctl command %d\n", cmd);
            return -ENOIOCTLCMD;
    }
}

static const struct file_operations ham_drv_fops = {
    .owner = THIS_MODULE,
    .unlocked_ioctl = ham_drv_ioctl,
    .llseek = no_llseek,
};

static irqreturn_t ham_drv_interrupt(int irq, void *dev_id)
{
    printk(KERN_INFO "ham_drv: irq %d\n", irq);
    if (irq != INTERRUPT_NUM) {
        return IRQ_NONE;
    }
    adc_value = ioread32(GET_ADC_OFFSET);
    printk(KERN_INFO "ham_drv: adc %ld\n", adc_value);
    return IRQ_HANDLED;
}

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

    ret = request_irq(INTERRUPT_NUM, ham_drv_interrupt, 0, "ham_drv", NULL); 
    if (ret != 0) {
        printk(KERN_ALERT "ham_drv: failed to request irq %d\n", INTERRUPT_NUM);
        goto fail_request_irq;
    }
    printk(KERN_INFO "ham_drv: request irq %d\n", INTERRUPT_NUM);

    printk(KERN_INFO "ham_drv: successfully initialized\n");
    return 0;

fail_request_irq:
    iounmap(ham_drv_mem);
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
    free_irq(INTERRUPT_NUM, 0);
    iounmap(ham_drv_mem);
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