#ifndef __THREAD_H__
#define __THREAD_H__

#define STACK_SIZE 1024
#define NR_TASKS 16 //最大线程数量
#define THREAD_SLEEP 1
#define THREAD_RUNNING 0
#define THREAD_EXIT -1
struct task_struct
{
    int id;                  // 线程 id
    void (*th_fn)();         // 线程过程函数
    int esp;                 // 栈顶指针
    unsigned int wakeuptime; // 线程唤醒时间
    int status;              // 线程的状态
    int counter;             //  时间片
    int priority;            // 优先级
    int stack[STACK_SIZE];   // 线程运行栈
};

int thread_create(int *tid, void (*start_routine)());
int thread_join(int tid);
#endif