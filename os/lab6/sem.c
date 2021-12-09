#define __LIBRARY__
#include <linux/sched.h>
#include <linux/kernel.h>
#include <asm/segment.h>
#include <asm/system.h>
#include <unistd.h>

#define NUM_SEM 32

sem_t semaphores[NUM_SEM];

sem_q *init_queue()
{
    sem_q *tmp = (struct node *)malloc(sizeof(struct node));
    tmp->front = tmp->rear = NULL;
    return tmp;
}
int is_empty(sem_q *q)
{
    return q->front == NULL;
}

struct task_struct *de_queue(sem_q *q)
{
    if (is_empty(q))
    {
        printk("empty queue!\n");
        return NULL;
    }
    struct node *tmp = q->front;
    if (q->rear == q->front)
        q->front = q->rear = NULL;
    else
        q->front = q->front->next;
    struct task_struct *p = tmp->next;
    free(tmp);
    return p;
}

int en_queue(struct task_struct *t, sem_q *q)
{

    struct node *tnode = (struct node *)malloc(sizeof(struct node));
    tnode->task = t;
    tnode->next = NULL;
    if (is_empty(q))
    {
        q->front = q->rear = tnode;
        return 1;
    }
    q->rear->next = tnode;
    q->rear = q->rear->next;
    return 1;
}

/* 创建一个信号量，或打开一个已经存在的信号量。*/
/*  name是信号量的名字。不同的进程可以通过提供同样的name而共享同一个信号量。
*   如果该信号量不存在，就创建新的名为name的信号量；
*   如果存在，就打开已经存在的名为name的信号量。 
*   value是信号量的初值，仅当新建信号量时，此参数才有效，其余情况下它被忽略。 
*   当成功时，返回值是该信号量的唯一标识（比如，在内核的地址、ID等），由另两个系统调用使用。
*   如失败，返回值是NULL。 
*/

sem_t *sys_sem_open(const char *name, unsigned int value)
{
    char tmp[20];
    int i = 0;
    for (i = 0; i < 20; i++)
    {
        tmp[i] = get_fs_byte(name + i);
        if (tmp[i] == '\0')
            break;
    }
    for (i = 0; i < NUM_SEM; i++)
    {
        if (strcmp(tmp, semaphores[i].name) == 0 && semaphores[i].openflag)
            return &semaphores[i];
    }
    for (i = 0; i < NUM_SEM; i++)
    {
        if (!semaphores[i].openflag)
        {
            strcpy(semaphores[i].name, tmp);
            semaphores[i].value = value;
            semaphores[i].openflag = 1;
            semaphores[i].wait_queue = init_queue();
            return &semaphores[i];
        }
    }
    printk("out of num sem range.\n");
    return NULL;
}
/*
*    sem_wait()就是信号量的P原子操作。
*   如果继续运行的条件不满足，则令调用进程等待在信号量sem上。
*   返回0表示成功，返回-1表示失败。
*/
int sys_sem_wait(sem_t *sem)
{
    cli();
    sem->value--;
    if (sem->value < 0)
    {
        current->state = TASK_UNINTERRUPTIBLE;
        en_queue(current, sem->wait_queue);
        /*
        
        if(strcmp("full",sem->name)!=0)
        */

        printk("wait task %s %d\n", sem->name, sem->value);
        schedule();
    }

    sti();
    return 0;
}

/* 信号量的V原子操作。如果有等待sem的进程，它会唤醒其中的一个。
    返回0表示成功，返回-1表示失败。 */
int sys_sem_post(sem_t *sem)
{
    cli();
    sem->value++;
    if (sem->value <= 0)
    {

        struct task_struct *tmp = de_queue(sem->wait_queue);
        tmp->state = TASK_RUNNING;

        printk("post task %s %d\n", sem->name, sem->value);
    }
    sti();
    return 0;
}

/* 删除名为name的信号量。返回0表示成功，返回-1表示失败。 */
int sys_sem_unlink(const char *name)
{
    char tmp[20];
    int i = 0;
    for (i = 0; i < 20; i++)
    {
        tmp[i] = get_fs_byte(name + i);
        if (tmp[i] == '\0')
            break;
    }
    for (i = 0; i < NUM_SEM; i++)
    {
        if (strcmp(tmp, semaphores[i].name) == 0 && semaphores[i].openflag)
        {
            semaphores[i].openflag = 0;
            semaphores[i].value = 0;
            strcpy(semaphores[i].name, "\0");
            return 0;
        }
        if (i == NUM_SEM - 1)
            return -1;
    }
    return -1;
}