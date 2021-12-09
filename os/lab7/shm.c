#define __LIBRARY__
#include <asm/segment.h>
#include <asm/system.h>
#include <errno.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <unistd.h>

#define LOW_MEM 0x100000 /* 内存低端 */
#define PAGING_MEMORY (15 * 1024 * 1024)
#define PAGING_PAGES (PAGING_MEMORY >> 12)
#define MAP_NR(addr) (((addr)-LOW_MEM) >> 12) /* 指定内存地址映射为页号 */

extern unsigned char mem_map[PAGING_PAGES];

/*
`shmget()` 会新建/打开一页内存，并返回该页共享内存的
shmid（该块共享内存在操作系统内部的 id）。

所有使用同一块共享内存的进程都要使用相同的 key 参数。

如果 key 所对应的共享内存已经建立，则直接返回 `shmid`。
如果 size 超过一页内存的大小，返回 `-1`，并置 `errno` 为 `EINVAL`。
如果系统无空闲内存，返回 -1，并置 `errno` 为 `ENOMEM`。

`shmflg` 参数可忽略。
*/
struct shm {
  int key;
  int used;
  long addr;
} ;
struct shm shmt[20];

int sys_shmget(int key, size_t size, int shmflg) {
  int i = 0;
  if (size > PAGE_SIZE) {
    errno = EINVAL;
    return -1;
  }

  /* 已开辟 */
  for (i = 0; i < 20; i++) {
    if (shmt[i].key == key && shmt[i].used)
      return i;
  }

  /* 未开辟 */
  for (i = 0; i < 20; i++) {
    if (!shmt[i].used) {
      shmt[i].used = 1;
      shmt[i].key = key;
      shmt[i].addr = get_free_page();
      return i;
    }
  }
  return -1;
}

/*
`shmat()` 会将 `shmid`
指定的共享页面映射到当前进程的虚拟地址空间中，并将其首地址返回。

如果 `shmid` 非法，返回 `-1`，并置 `errno` 为 `EINVAL`。

`shmaddr` 和 `shmflg` 参数可忽略。
*/
void *sys_shmat(int shmid, const void *shmaddr, int shmflg) {
  if (shmid < 0 || shmid >= 20 || !shmt[shmid].used) {
    errno = EINVAL;
    return (void *)-1;
  }
  /* 把mem_map数组中的对应字节+1 （搞一些会内存泄漏的东西x）
  mem_map[MAP_NR(shmt[shmid].addr)]++;*/
  put_page(shmt[shmid].addr, current->start_code + current->brk);
  return (void *)current->brk;
}