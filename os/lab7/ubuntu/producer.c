#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <semaphore.h>
#include <sys/ipc.h>
#include <sys/shm.h>
/*
_syscall2(sem_t*,sem_open,const char *,name,unsigned int,value)
_syscall1(int,sem_wait,sem_t*,sem)
_syscall1(int,sem_post,sem_t*,sem)
_syscall1(int,sem_unlink,const char*,name)

_syscall3(int,shmget,key_t,key,int,size,int,shmflg);
_syscall3(void*,shmat,int,shmid,const void *,shmaddr, int,shmflg);


*/


#define BUFFER_SIZE 10      /* 缓冲区大小为10*/
#define NUM_CONSUMER 20     /*消费者数量*/
#define NUM_NUM 100         /*字符个数*/

sem_t *mutex,*full,*empty;
int shm_in=0;
int shmid;
int *shm;

void Producer(int x);

int main()
{
    int i=0;
    if((empty=sem_open("empty",O_CREAT,0666,BUFFER_SIZE))==NULL)
    {
        perror("sem_open empty error\n");
        return -1;
    }
    if((full=sem_open("full",O_CREAT,0666,0))==NULL)
    {
        perror("sem_open full error\n");
        return -1;
    }
    if((mutex=sem_open("mutex",O_CREAT,0666,1))==NULL)
    {
        perror("sem_open empty error\n");
        return -1;
    }
    /* 创建共享内存 */
    shmid=shmget((key_t)0123,BUFFER_SIZE,0666|IPC_CREAT);
    if (shmid == -1)
    {
        printf("shmget error\n");
        return -1;
    }
    /* 将共享内存连接到当前进程的地址空间 */
    shm=(int*)shmat(shmid,0,0);
    if (shm == (int*)-1)
    {
        printf("shmat error\n");
        return -1;
    }
    /* 生产者 */
    
    for(i=0;i<NUM_NUM;i++)
    {
        Producer(i);
    }
        

    wait(NULL);
    sem_unlink("empty");
    sem_unlink("full");
    sem_unlink("mutex");
    /* 删除共享内存 */
    shmdt(shm);
    shmctl(shmid, IPC_RMID, 0);
    return 0;
}

void Producer(int x)
{
    sem_wait(empty);
    sem_wait(mutex);
    /*写入一个字符*/
    shm[shm_in]=x;
    shm_in=(shm_in+1)%BUFFER_SIZE;
    sem_post(mutex);
    sem_post(full);
}