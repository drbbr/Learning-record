
#include <stdio.h>
#include <stdlib.h>
#include "thread.h"
void switch_to(struct task_struct *next); // 定义在 switch.s 中

static struct task_struct init_task = {0, NULL, 0, {0}};
struct task_struct *current = &init_task;
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

void schedule()
{
    struct task_struct *next = pick();
    if (next)
    {
        switch_to(next);
    }
}