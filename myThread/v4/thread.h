#ifndef __THREAD_H__
#define __THREAD_H__

#define STACK_SIZE 1024
#define NR_TASKS 16 //最大线程数量
#define THREAD_SLEEP 1
#define THREAD_RUNNING 0

struct task_struct
{
    int id;                  // 线程 id
    void (*th_fn)();         // 线程过程函数
    int esp;                 // 栈顶指针
    unsigned int wakeuptime; // 线程唤醒时间
    int status;              // 线程的状态
    int stack[STACK_SIZE];
};

struct task_struct *task[NR_TASKS];
int thread_create(int *tid, void (*start_routine)());

#endif