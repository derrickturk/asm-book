# do an "exit" syscall, using sysenter instruction
.section .data
hello: .ascii "goodbye world\n"
.set hellosize, . - hello

.section .text
.globl _start
_start:
# syscall 4 / write
movl $4, %eax
# stdout
movl $1, %ebx
# our string and its size
movl $hello, %ecx
movl $hellosize, %edx
# for sysenter: push return address
pushl $return
pushl %ecx # save ecx, edx, ebp
pushl %edx
pushl %ebp
movl %esp, %ebp # save current SP as base
sysenter
return:

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
