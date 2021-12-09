#include <unistd.h> // for sleep
#include <stdio.h>
#include <stdlib.h>
#include "thread.h"
void switch_to(struct task_struct *next); // 定义在 switch.s 中
void schedule();
void fun1()
{
    while (1)
    {
        printf("hello, I'm fun1\n");
        mysleep(3);
    }
}

void fun2()
{
    while (1)
    {
        printf("hello, I'm fun2\n");
        mysleep(4);
    }
}

void fun3()
{
    while (1)
    {
        printf("hello, I'm fun3\n");
        mysleep(5);
    }
}

int main()
{
    int tid1, tid2, tid3;
    if (thread_create(&tid1, fun1) != 0)
        printf("error create 1");
    if (thread_create(&tid2, fun2) != 0)
        printf("error create 2");
    if (thread_create(&tid3, fun3) != 0)
        printf("error create 3");

    while (1)
    {
        printf("hello, I'm main\n");
        mysleep(1);
    }
}