#include <linux/cdev.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/spinlock.h>
#include <linux/spinlock_types.h>
#include <asm/uaccess.h>
#include "ioctl_commands.h"

#define DEVICE_NAME                    "ham"
#define UINPUT_BASE                    0xff200000
#define UINPUT_SIZE                    0x00070000
#define INTERRUPT_DMA_COMPLETE         72
#define INTERRUPT_DMA_READY            77


#define MODULE_OFFSET                  (ham_drv_mem + 0x00050000)
#define SET_FFT_FREQ_OFFSET            (MODULE_OFFSET)
#define SET_THRESHOLD_OFFSET           (MODULE_OFFSET + 4)
#define SET_SIM_DELAY_1_OFFSET         (MODULE_OFFSET + 8)
#define SET_SIM_DELAY_2_OFFSET         (MODULE_OFFSET + 12)
#define SET_SIM_DELAY_3_OFFSET         (MODULE_OFFSET + 16)
#define SET_SIM_PHASE_INC_OFFSET       (MODULE_OFFSET + 20)
#define SET_SIM_FLAG_OFFSET            (MODULE_OFFSET + 24)
#define SET_SIM_PING_TIME_OFFSET       (MODULE_OFFSET + 28)
#define SET_SIM_WAIT_TIME_OFFSET       (MODULE_OFFSET + 32)


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

static void *buffer;

static DEFINE_SPINLOCK(dma_lock);
static int dma_complete = 0;
static unsigned long irq_flags;

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
    int i;
    for (i = 0; i < DMA_BUFFER_SIZE; ++i) {
        unsigned char byte = (*((unsigned char *)(buffer + i)));
        printk(KERN_INFO "ham_drv: dma data %2d: %02X(%3u)\n", i, byte, byte);
    }
}

static ssize_t ham_drv_read(struct file *filep, char __user *out_buffer, size_t count, loff_t *offset)
{
    if (spin_trylock_irqsave(&dma_lock, irq_flags) != 0) {
        if (dma_complete == 1) {
            dma_complete = 0;
            if (copy_to_user(out_buffer, buffer, DMA_BUFFER_SIZE)) {
                spin_unlock_irqrestore(&dma_lock, irq_flags);
                return -EINVAL;
            }
            spin_unlock_irqrestore(&dma_lock, irq_flags);
            return DMA_BUFFER_SIZE;
        } else {
            spin_unlock_irqrestore(&dma_lock, irq_flags);
        }
    }
    return 0;
}

static long ham_drv_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
{
    switch (cmd) {
        case IOCTL_SET_FFT_FREQ:
            printk(KERN_INFO "ham_drv: ioctl fft freq %lu\n", arg);
            iowrite32(arg, SET_FFT_FREQ_OFFSET);
            return 0;
        case IOCTL_SET_THRESHOLD:
            printk(KERN_INFO "ham_drv: ioctl threshold freq %lu\n", arg);
            iowrite32(arg, SET_THRESHOLD_OFFSET);
            return 0;
        case IOCTL_SET_SIM_DELAY_1:
            printk(KERN_INFO "ham_drv: ioctl sim delay 1 %lu\n", arg);
            iowrite32(arg, SET_SIM_DELAY_1_OFFSET);
            return 0;
        case IOCTL_SET_SIM_DELAY_2:
            printk(KERN_INFO "ham_drv: ioctl sim delay 2 %lu\n", arg);
            iowrite32(arg, SET_SIM_DELAY_2_OFFSET);
            return 0;
        case IOCTL_SET_SIM_DELAY_3:
            printk(KERN_INFO "ham_drv: ioctl sim delay 3 %lu\n", arg);
            iowrite32(arg, SET_SIM_DELAY_3_OFFSET);
            return 0;
        case IOCTL_SET_SIM_PHASE_INC:
            printk(KERN_INFO "ham_drv: ioctl sim phase inc %lu\n", arg);
            iowrite32(arg, SET_SIM_PHASE_INC_OFFSET);
            return 0;
        case IOCTL_SET_SIM_FLAG:
            printk(KERN_INFO "ham_drv: ioctl sim flag %lu\n", arg);
            iowrite32(arg, SET_SIM_FLAG_OFFSET);
            return 0;
        case IOCTL_SET_SIM_PING_TIME:
            printk(KERN_INFO "ham_drv: ioctl sim ping time %lu\n", arg);
            iowrite32(arg, SET_SIM_PING_TIME_OFFSET);
            return 0;
        case IOCTL_SET_SIM_WAIT_TIME:
            printk(KERN_INFO "ham_drv: ioctl sim wait time %lu\n", arg);
            iowrite32(arg, SET_SIM_WAIT_TIME_OFFSET);
            return 0;
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

static irqreturn_t ham_drv_interrupt_dma_complete(int irq, void *dev_id)
{
    if (irq != INTERRUPT_DMA_COMPLETE) {
        return IRQ_NONE;
    }
    ham_drv_dma_write_reg(DMA_CONTROL_REG_BIT_HALFWORD | DMA_CONTROL_REG_BIT_LEEN, CONTROL);
    ham_drv_dma_write_reg(0, STATUS);
    dma_complete = 1;
    spin_unlock(&dma_lock);
    return IRQ_HANDLED;
}

static irqreturn_t ham_drv_interrupt_dma_ready(int irq, void *dev_id)
{
    if (irq != INTERRUPT_DMA_READY) {
        return IRQ_NONE;
    }
    spin_lock(&dma_lock);
    dma_complete = 0;
    unsigned int control_reg = DMA_CONTROL_REG_BIT_HALFWORD | DMA_CONTROL_REG_BIT_INTERRUPT | DMA_CONTROL_REG_BIT_LEEN;
    ham_drv_dma_write_reg(control_reg, CONTROL);
    ham_drv_dma_write_reg((unsigned int)buffer, WRITEADDRESS);
    ham_drv_dma_write_reg(DMA_BUFFER_SIZE, LENGTH);
    ham_drv_dma_write_reg(0, READADDRESS);
    ham_drv_dma_write_reg(control_reg | DMA_CONTROL_REG_BIT_GO, CONTROL);
    return IRQ_HANDLED;
}

static int __init ham_drv_init(void)
{
    int ret = 0;
    dma_complete = 0;

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

    ret = request_irq(INTERRUPT_DMA_COMPLETE, ham_drv_interrupt_dma_complete, 0, "ham_drv", NULL); 
    if (ret != 0) {
        printk(KERN_ALERT "ham_drv: failed to request irq %d\n", INTERRUPT_DMA_COMPLETE);
        goto fail_request_irq_1;
    }
    printk(KERN_INFO "ham_drv: request irq %d\n", INTERRUPT_DMA_COMPLETE);

    ret = request_irq(INTERRUPT_DMA_READY, ham_drv_interrupt_dma_ready, 0, "ham_drv", NULL); 
    if (ret != 0) {
        printk(KERN_ALERT "ham_drv: failed to request irq %d\n", INTERRUPT_DMA_READY);
        goto fail_request_irq_2;
    }
    printk(KERN_INFO "ham_drv: request irq %d\n", INTERRUPT_DMA_READY);

    buffer = kmalloc(DMA_BUFFER_SIZE, GFP_DMA);
    if (buffer == NULL) {
        goto fail_kmalloc_buffer;
    }

    printk(KERN_INFO "ham_drv: successfully initialized\n");
    return 0;

fail_kmalloc_buffer:
    free_irq(INTERRUPT_DMA_READY, 0);
fail_request_irq_2:
    free_irq(INTERRUPT_DMA_COMPLETE, 0);
fail_request_irq_1:
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
    kfree(buffer);
    free_irq(INTERRUPT_DMA_READY, 0);
    free_irq(INTERRUPT_DMA_COMPLETE, 0);
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