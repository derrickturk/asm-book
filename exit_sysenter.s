# do an "exit" syscall, using sysenter instruction
.globl _start
_start:
# syscall 1 / exit : status 13
movl $1, %eax
movl $13, %ebx
# required for sysenter: we must push
pushl $0 # the return address (it's exit, so we're not coming back)
pushl %ecx # save ecx, edx, ebp
pushl %edx
pushl %ebp
movl %esp, %ebp # save current SP as base
sysenter
