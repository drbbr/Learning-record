#define __LIBRARY__
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
_syscall2(sem_t *, sem_open, const char *, name, unsigned int, value);
_syscall1(int, sem_wait, sem_t *, sem);
_syscall1(int, sem_post, sem_t *, sem);
_syscall1(int, sem_unlink, const char *, name);

_syscall3(int, shmget, int, key, int, size, int, shmflg);
_syscall3(void *, shmat, int, shmid, const void *, shmaddr, int, shmflg);

#define BUFFER_SIZE 10  /* 缓冲区大小为10*/
#define NUM_CONSUMER 20 /*消费者数量*/
#define NUM_NUM 100     /*字符个数*/

sem_t *mutex, *full, *empty;
int shm_out = 0;
int shmid;
int *shm;

void Consumer();

int main() {
  int i = 0, j = 0;
  if ((empty = sem_open("empty", BUFFER_SIZE)) == NULL) {
    perror("sem_open empty error\n");
    return -1;
  }
  if ((full = sem_open("full", 0)) == NULL) {
    perror("sem_open full error\n");
    return -1;
  }
  if ((mutex = sem_open("mutex", 1)) == NULL) {
    perror("sem_open empty error\n");
    return -1;
  }
  /* 创建共享内存 */
  shmid = shmget((int)0123, BUFFER_SIZE, 0);
  if (shmid == -1) {
    printf("shmget error\n");
    return -1;
  }
  /* 将共享内存连接到当前进程的地址空间 */
  shm = (int *)shmat(shmid, 0, 0);
  if (shm == (int *)-1) {
    printf("shmat error\n");
    return -1;
  }
  /* 消费者 */
  for (i = 0; i < NUM_CONSUMER; i++) {
    if (!fork()) {
      for (j = 0; j < NUM_NUM / NUM_CONSUMER; j++) {
        Consumer();
      }
      return 0;
    }
  }
  wait(NULL);
  sem_unlink("empty");
  sem_unlink("full");
  sem_unlink("mutex");
  return 0;
}

void Consumer() {
  int n;
  sem_wait(full);
  sem_wait(mutex);

  /*获取shmout*/
  shm_out = shm[BUFFER_SIZE];

  /*读取缓冲区内容*/
    n = shm[shm_out];

  /*shmout++并写入缓冲区*/
  shm_out = (shm_out + 1) % BUFFER_SIZE;
  shm[BUFFER_SIZE] = shm_out;

  printf("%d\t%d\n", getpid(), n);
  fflush(stdout);
  sem_post(mutex);
  sem_post(empty);
}
