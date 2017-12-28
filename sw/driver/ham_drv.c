#include <linux/cdev.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <asm/uaccess.h>
#include "ioctl_commands.h"

#define DEVICE_NAME                    "ham"
#define UINPUT_BASE                    0xff200000
#define UINPUT_SIZE                    0x00070000
#define INTERRUPT_NUM                  72


#define MODULE_OFFSET                  (ham_drv_mem + 0x00050000)
#define GET_ADC_OFFSET                 (MODULE_OFFSET + 1 * sizeof(u32))

#define DMA_MODULE_OFFSET              (ham_drv_mem + 0x00000000)
#define DMA_STATUS_REG_OFFSET          (DMA_MODULE_OFFSET)
#define DMA_READADDRESS_REG_OFFSET     (DMA_MODULE_OFFSET + 4)
#define DMA_WRITEADDRESS_REG_OFFSET    (DMA_MODULE_OFFSET + 8)
#define DMA_LENGTH_REG_OFFSET          (DMA_MODULE_OFFSET + 12)
#define DMA_CONTROL_REG_OFFSET         (DMA_MODULE_OFFSET + 24)

#define DMA_CONTROL_REG_BIT_BYTE          (1 << 0)
#define DMA_CONTROL_REG_BIT_HALFWORD      (1 << 1)
#define DMA_CONTROL_REG_BIT_WORD          (1 << 2)
#define DMA_CONTROL_REG_BIT_GO            (1 << 3)
#define DMA_CONTROL_REG_BIT_INTERRUPT     (1 << 4)
#define DMA_CONTROL_REG_BIT_REEN          (1 << 5)
#define DMA_CONTROL_REG_BIT_WEEN          (1 << 6)
#define DMA_CONTROL_REG_BIT_LEEN          (1 << 7)
#define DMA_CONTROL_REG_BIT_RCON          (1 << 8)
#define DMA_CONTROL_REG_BIT_WCON          (1 << 9)
#define DMA_CONTROL_REG_BIT_DOUBLEWORD    (1 << 10)
#define DMA_CONTROL_REG_BIT_QUADWORD      (1 << 11)
#define DMA_CONTROL_REG_BIT_SOFTWARERESET (1 << 12)

enum DmaRegisters
{
    STATUS,
    READADDRESS,
    WRITEADDRESS,
    LENGTH,
    CONTROL
};

#define DMA_BUFFER_SIZE 1024 * 3 * 2 


static void *ham_drv_mem = NULL;
static struct class *ham_drv_class  = NULL;
static struct device *ham_drv_device = NULL;

static int major_number;

static int adc_value = 0;
static void *buffer;


static void* ham_drv_dma_get_reg_offset(enum DmaRegisters reg)
{
    switch(reg) {
    case STATUS: {
        return DMA_STATUS_REG_OFFSET;
    }
    case READADDRESS: {
        return DMA_READADDRESS_REG_OFFSET;
    }
    case WRITEADDRESS: {
        return DMA_WRITEADDRESS_REG_OFFSET;
    }
    case LENGTH: {
        return DMA_LENGTH_REG_OFFSET;
    }
    case CONTROL: {
        return DMA_CONTROL_REG_OFFSET;
    }
    default: {
        return NULL;
    }
    }
}

static unsigned int ham_drv_dma_read_reg(enum DmaRegisters reg)
{
    return ioread32(ham_drv_dma_get_reg_offset(reg));
}

static void ham_drv_dma_write_reg(unsigned int value, enum DmaRegisters reg)
{
    return iowrite32(value, ham_drv_dma_get_reg_offset(reg));
}

static void ham_drv_dma_print_registers(void)
{
    printk(KERN_INFO "ham_drv: dma reg status           %u\n", ham_drv_dma_read_reg(STATUS));
    printk(KERN_INFO "ham_drv: dma reg readaddress      %X\n", ham_drv_dma_read_reg(READADDRESS));
    printk(KERN_INFO "ham_drv: dma reg writeaddress     %X\n", ham_drv_dma_read_reg(WRITEADDRESS));
    printk(KERN_INFO "ham_drv: dma reg length           %u\n", ham_drv_dma_read_reg(LENGTH));
    printk(KERN_INFO "ham_drv: dma reg control          %u\n", ham_drv_dma_read_reg(CONTROL));
}

static void ham_drv_dma_print_data(void)
{
    for (int i = 0; i < DMA_BUFFER_SIZE; ++i) {
        unsigned char byte = (*((unsigned char *)(buffer + i)));
        printk(KERN_INFO "ham_drv: dma data %2d: %02X(%3u)\n", i, byte, byte);
    }
}

static ssize_t ham_drv_read(struct file *filep, char __user *out_buffer, size_t count, loff_t *offset)
{
    if (copy_to_user(out_buffer, buffer, DMA_BUFFER_SIZE)) {
        return -EINVAL;
    }
    return DMA_BUFFER_SIZE;
}

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
    .read  = ham_drv_read,
    .unlocked_ioctl = ham_drv_ioctl,
    .llseek = no_llseek,
};

static irqreturn_t ham_drv_interrupt(int irq, void *dev_id)
{
    printk(KERN_INFO "ham_drv: irq %d\n", irq);
    if (irq != INTERRUPT_NUM) {
        return IRQ_NONE;
    }
    ham_drv_dma_write_reg(DMA_CONTROL_REG_BIT_HALFWORD | DMA_CONTROL_REG_BIT_LEEN, CONTROL);
    ham_drv_dma_print_registers();
    ham_drv_dma_write_reg(0, STATUS);
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

    buffer = kmalloc(DMA_BUFFER_SIZE, GFP_DMA);
    if (buffer == NULL) {
        goto fail_kmalloc_buffer;
    }

    ham_drv_dma_print_registers();
    unsigned int control_reg = DMA_CONTROL_REG_BIT_HALFWORD | DMA_CONTROL_REG_BIT_INTERRUPT | DMA_CONTROL_REG_BIT_LEEN;
    ham_drv_dma_write_reg(control_reg, CONTROL);

    ham_drv_dma_print_registers();
    ham_drv_dma_write_reg((unsigned int)buffer, WRITEADDRESS);
    ham_drv_dma_write_reg(DMA_BUFFER_SIZE, LENGTH);
    ham_drv_dma_write_reg(0, READADDRESS);

    ham_drv_dma_print_registers();
    ham_drv_dma_write_reg(control_reg | DMA_CONTROL_REG_BIT_GO, CONTROL);

    ham_drv_dma_print_registers();
    printk(KERN_INFO "ham_drv: successfully initialized\n");
    return 0;

fail_kmalloc_buffer:
    free_irq(INTERRUPT_NUM, 0);
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
    ham_drv_dma_print_data();
    kfree(buffer);
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