#ifndef __THREAD_H__
#define __THREAD_H__

#define STACK_SIZE 1024
#define NR_TASKS 16 //最大线程数量

struct task_struct
{
    int id;          // 线程 id
    void (*th_fn)(); //线程过程函数
    int esp;         //栈顶指针
    int stack[STACK_SIZE];
};

struct task_struct *task[NR_TASKS];
int thread_create(int *tid, void (*start_routine)());

#endif