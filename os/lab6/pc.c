#define   __LIBRARY__
#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>


_syscall2(sem_t*,sem_open,const char *,name,unsigned int,value)
_syscall1(int,sem_wait,sem_t*,sem)
_syscall1(int,sem_post,sem_t*,sem)
_syscall1(int,sem_unlink,const char*,name)

#define FILENAME "/usr/root/buffer_file"    /*缓冲文件*/
#define BUFFER_SIZE 10   /* 缓冲区大小为10*/
#define NUM_CONSUMER 20     /*消费者数量*/
#define NUM_NUM 100     

sem_t *mutex,*full,*empty;
int fin=0,fout=0;
int fbuf;
void Producer();
void Consumer();
void C();
void P();
int main()
{

    int i=0,j=0, nums=0;
    if((empty=sem_open("empty",BUFFER_SIZE))==NULL)
    {
        perror("sem_open empty error\n");
    }
    if((full=sem_open("full",0))==NULL)
    {
        perror("sem_open full error\n");
    }
    if((mutex=sem_open("mutex",1))==NULL)
    {
        perror("sem_open empty error\n");
    }
    fbuf=open(FILENAME,O_CREAT|O_RDWR,0666);
    lseek(fbuf,BUFFER_SIZE*sizeof(int),SEEK_SET);
    write(fbuf,(char*)&fout,sizeof(int));

    if(!fork())    /*一个生产者*/
    {
        P();
        printf("%d",j);
        return 0;
    }
    /*N个消费者*/
    for(i=0;i<NUM_CONSUMER;i++)
    {
        if(!fork())
        {
            sleep(20);
            C();
            return 0;
        }
    }    
    wait(NULL);
    sem_unlink("empty");
    sem_unlink("full");
    sem_unlink("mutex");
    close(fbuf);
    return 0;
}



void Producer(int x)
{
    sem_wait(empty);
    sem_wait(mutex);
    /*写入一个字符*/
    lseek(fbuf,fin*sizeof(int),SEEK_SET);
    write(fbuf,(char*)&x,sizeof(int));
    fin=(fin+1)%BUFFER_SIZE;
    sem_post(mutex);
    sem_post(full);
    printf("post full %d\n",x);
}

void Consumer(){
    int n;
    sem_wait(full);
    sem_wait(mutex);
    /*获得读取位置*/
    lseek(fbuf,BUFFER_SIZE*sizeof(int),SEEK_SET);
    read(fbuf,(char*)&fout,sizeof(int));
    /*读取数据*/
    lseek(fbuf,fout*sizeof(int),SEEK_SET);
    read(fbuf,(char*)&n,sizeof(int));
    /*写入读取位置*/
    fout=(fout+1)%BUFFER_SIZE;
    lseek(fbuf,BUFFER_SIZE*sizeof(int),SEEK_SET);
    write(fbuf,(char*)&fout,sizeof(int));

    printf("%d\t%d\n",getpid(),n);
    fflush(stdout);
    sem_post(mutex);
    sem_post(empty);
}

void P(){
    int i;
    for(i=0;i<NUM_NUM;i++)
    {
        Producer(i);
    }
}

void C(){
    int i;
    for(i=0;i<NUM_NUM/NUM_CONSUMER;i++)
    {
        Consumer();
    }
}