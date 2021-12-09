#include <unistd.h> // for sleep
#include <stdio.h>
#include <stdlib.h>
#define STACK_SIZE 1024
#define NR_TASKS 16 //最大线程数量

struct task_struct
{
    int id;          // 线程 id
    void (*th_fn)(); //线程过程函数
    int esp;         //栈顶指针
    int stack[STACK_SIZE];
};
static struct task_struct init_task = {0, NULL, 0, {0}};

struct task_struct *current = &init_task;

void switch_to(struct task_struct *next); // 定义在 switch.s 中
struct task_struct *task[NR_TASKS];

struct task_struct *pick()
{
    int current_id = current->id;
    int i = current_id;

    struct task_struct *next = NULL;

    // 寻找下一个不空的线程
    while (1)
    {
        i = (i + 1) % NR_TASKS;

        if (task[i])
        {
            next = task[i];
            break;
        }
    }

    return next;
}

// 线程启动函数
void start(struct task_struct *tsk)
{
    tsk->th_fn();
    task[tsk->id] = NULL;
    struct task_struct *next = pick();
    if (next)
        switch_to(next);
}

int thread_create(int *tid, void (*start_routine)())
{
    int id = -1;
    // malloc memory for task
    struct task_struct *tsk = (struct task_struct *)malloc(sizeof(struct task_struct));
    // find empty position
    while (++id < NR_TASKS && task[id])
        ;
    if (id == NR_TASKS)
        return -1;

    task[id] = tsk;
    if (tid)
        *tid = id;
    tsk->id = id;
    tsk->th_fn = start_routine;
    int *stack = tsk->stack;
    tsk->esp = (int)(stack + STACK_SIZE - 11);

    //initialize stack
    stack[STACK_SIZE - 11] = 7;
    stack[STACK_SIZE - 10] = 6;         // eax
    stack[STACK_SIZE - 9] = 5;          // edx
    stack[STACK_SIZE - 8] = 4;          // ecx
    stack[STACK_SIZE - 7] = 3;          // ebx
    stack[STACK_SIZE - 6] = 2;          // esi
    stack[STACK_SIZE - 5] = 1;          // edi
    stack[STACK_SIZE - 4] = 0;          // old ebp
    stack[STACK_SIZE - 3] = (int)start; // ret to start
    // start 函数栈帧，刚进入 start 函数的样子
    stack[STACK_SIZE - 2] = 100;      // ret to unknown，如果 start 执行结束，表明线程结束
    stack[STACK_SIZE - 1] = (int)tsk; // start 的参数
    return 0;
}

void fun1()
{
    while (1)
    {
        printf("hello, I'm fun1\n");
        sleep(1);
        struct task_struct *next = pick();
        if (next)
        {
            switch_to(next);
        }
    }
}

void fun2()
{
    while (1)
    {
        printf("hello, I'm fun2\n");
        sleep(1);
        struct task_struct *next = pick();
        if (next)
        {
            switch_to(next);
        }
    }
}

void fun3()
{
    while (1)
    {
        printf("hello, I'm fun3\n");
        sleep(1);
        struct task_struct *next = pick();
        if (next)
        {
            switch_to(next);
        }
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
        sleep(1);
        struct task_struct *next = pick();
        if (next)
        {
            switch_to(next);
        }
    }
}