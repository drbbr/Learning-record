#include <unistd.h> // for sleep
#include <stdio.h>
#include <stdlib.h>
#include "thread.h"

void fun1()
{
    int i = 10;
    while (i--)
    {
        printf("hello, I'm fun1\n");
        mysleep(2);
    }
}

void fun2()
{
    int i = 10;
    while (i--)
    {
        printf("hello, I'm fun2\n");
        mysleep(1);
    }
}

void fun3()
{
    int i = 2;
    while (i--)
    {
        printf("hello, I'm fun3\n");
        mysleep(5);
    }
}

void fun4()
{
    int i = 15;
    int m;
    int n;
    while (i--)
    {
        printf("hello, I'm fun4\n");
        // sleep 会失效（因为有信号产生），这里用循环。
        for (m = 0; m < 10000; ++m)
            for (n = 0; n < 10000; ++n)
                ;
    }
}

int main()
{
    int tid1, tid2, tid3, tid4;
    if (thread_create(&tid1, fun1) != 0)
        printf("error create 1");
    if (thread_create(&tid2, fun2) != 0)
        printf("error create 2");
    if (thread_create(&tid3, fun3) != 0)
        printf("error create 3");
    if (thread_create(&tid4, fun4) != 0)
        printf("error create 4");
    int i = 2;
    while (i--)
    {
        printf("hello, I'm main\n");
        mysleep(3);
    }
    thread_join(tid1);
    thread_join(tid2);
    thread_join(tid3);
    thread_join(tid4);
    return 0;
}