/*void switch_to(int n)*/

.section .text
.global switch_to 
switch_to:
  push %ebp
  mov %esp, %ebp /* 更改栈帧，以便寻参 */

  /* 保存现场 */
  push %edi
  push %esi
  push %ebx
  push %edx
  push %ecx
  push %eax
  pushfl

  /* 准备切换栈 */
  mov current, %eax /* 保存当前 esp , eax 是 current 基址 */
  mov %esp, 8(%eax)
  mov 8(%ebp), %eax /* 取下一个线程结构体基址 */
  mov %eax, current /* 更新current */
  mov 8(%eax), %esp /* 切换到下一个线程的栈 */

  /* 恢复现场, 到这里，已经进入另一个线程环境了，本质是 esp 改变 */
  popfl
  popl %eax
  popl %edx
  popl %ecx
  popl %ebx
  popl %esi
  popl %edi

  popl %ebp
  ret 
