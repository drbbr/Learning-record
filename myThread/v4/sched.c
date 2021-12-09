
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "thread.h"
void switch_to(struct task_struct *next); // 定义在 switch.s 中

static struct task_struct init_task = {0, NULL, THREAD_RUNNING, 0, 0, {0}};
struct task_struct *current = &init_task;

static unsigned int getmstime()
{
    struct timeval tv;
    if (gettimeofday(&tv, NULL) < 0)
    {
        perror("gettimeofday");
        exit(-1);
    }
    return tv.tv_sec * 1000 + tv.tv_usec / 1000;
}

struct task_struct *pick()
{
    int current_id = current->id;
    int i;

    struct task_struct *next = NULL;

repeat:
    for (i = 0; i < NR_TASKS; ++i)
    {
        if (task[i] && task[i]->status == THREAD_SLEEP)
        {
            if (getmstime() > task[i]->wakeuptime)
            {
                task[i]->status = THREAD_RUNNING;
            }
        }
    }
    i = current_id;
    while (1)
    {
        i = (i + 1) % NR_TASKS;
        if (i == current_id)
        {
            goto repeat;
        }
        if (task[i] && task[i]->status == THREAD_RUNNING)
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

void mysleep(int seconds)
{
    current->wakeuptime = getmstime() + 1000 * seconds;
    current->status = THREAD_SLEEP;
    schedule();
}
