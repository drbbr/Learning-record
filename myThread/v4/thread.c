#include <stdio.h>
#include <stdlib.h>
#include "thread.h"
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
    tsk->wakeuptime = 0;
    tsk->status = THREAD_RUNNING;

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