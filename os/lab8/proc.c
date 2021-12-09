#include <sys/stat.h>
#include <errno.h>
#include <sys/types.h>

#include <linux/kernel.h>
#include <linux/sched.h>
#include <asm/segment.h>
#include <asm/system.h>
#include <stdarg.h>

char proc_buf[4096] = {'\0'};

int sprintf(char *buf, const char *fmt, ...)
{
    va_list args;
    int i;
    va_start(args, fmt);
    i = vsprintf(buf, fmt, args);
    va_end(args);
    return i;
}

int countHM(int n)
{
    register int x = n;
    x = (x & 0x55555555) + ((x >> 1) & 0x55555555);
    x = (x & 0x33333333) + ((x >> 2) & 0x33333333);
    x = (x & 0x0f0f0f0f) + ((x >> 4) & 0x0f0f0f0f);
    x = (x * 0x01010101) >> 24;
    return x;
}

void psinfo()
{
    int buf_off = 0;
    buf_off += sprintf(proc_buf, "%s", "pid\tstate\tfather\tcounter\tstart_time\n");
    struct task_struct **p;
    for (p = &LAST_TASK; p > &FIRST_TASK; --p)
        if (*p)
            buf_off += sprintf(proc_buf + buf_off, "%d\t%d\t%d\t%d\t%d\n", (*p)->pid, (*p)->state, (*p)->father, (*p)->counter, (*p)->start_time);
    proc_buf[buf_off] = '\0';
    return buf_off;
}

void hdinfo()
{
    int buf_off = 0;
    int used = 0;
    int i = 0, j = 0;
    int n = 0;
    struct super_block *sb;
    struct buffer_head *bh;
    sb = get_super(current->root->i_dev);
    buf_off += sprintf(proc_buf + buf_off, "Total blocks : %d\n", sb->s_nzones);
    /* 算出已用的逻辑块数 */
    for (i = 0; i < sb->s_zmap_blocks; i++)
    {
        bh = sb->s_zmap[i];
        for (j = 0; j < 1024; j += 4)
        {
            n = bh->b_data[j];
            n = (n << 8) + bh->b_data[j + 1];
            n = (n << 8) + bh->b_data[j + 2];
            n = (n << 8) + bh->b_data[j + 3];
            used += countHM(n);
        }
    }
    buf_off += sprintf(proc_buf + buf_off, "Used blocks:%d\n", used);
    buf_off += sprintf(proc_buf + buf_off, "Free blocks:%d\n", sb->s_nzones - used);
    used = 0;
    n = 0;
    buf_off += sprintf(proc_buf + buf_off, "Total inodes:%d\n", sb->s_ninodes);
    /* 算出已用的节点数 */
    for (i = 0; i < sb->s_imap_blocks; i++)
    {
        bh = sb->s_imap[i];
        for (j = 0; j < 1024; j += 4)
        {
            n = bh->b_data[j];
            n = (n << 8) + bh->b_data[j + 1];
            n = (n << 8) + bh->b_data[j + 2];
            n = (n << 8) + bh->b_data[j + 3];
            used += countHM(n);
        }
    }

    buf_off += sprintf(proc_buf + buf_off, "Used inodes:%d\n", used);
    buf_off += sprintf(proc_buf + buf_off, "Free inodes:%d\n", sb->s_ninodes - used);
    proc_buf[buf_off] = '\0';
    return buf_off;
}

/*
    proc 文件的处理函数的功能是根据设备编号，把不同的内容写入到用户空间的 buf。
    写入的数据要从 `f_pos` 指向的位置开始，每次最多写 count 个字节，
    并根据实际写入的字节数调整 `f_pos` 的值，最后返回实际写入的字节数。
    当设备编号表明要读的是 psinfo 的内容时，就要按照 psinfo 的形式组织数据。
实现此函数可能要用到如下几个函数：malloc() 函数 free() 函数
包含 `linux/kernel.h` 头文件后，就可以使用 `malloc()` 和 `free()` 函数。
它们是可以被核心态代码调用的，唯一的限制是一次申请的内存大小不能超过一个页面。
*/
int proc_read(int dev, char *buf, int count, off_t *pos)
{
    int i;
    /* psinfo */
    if (dev == 0)
    {
        cli();
        psinfo();
        sti();
    }
    /* hdinfo */
    if (dev == 3)
    {
        cli();
        hdinfo();
        sti();
    }
    for (i = 0; i < count; i++)
    {
        if (proc_buf[i + *pos] == '\0')
            break;
        put_fs_byte(proc_buf[i + *pos], buf + i + *pos);
    }
    *pos += i;
    return i;
}