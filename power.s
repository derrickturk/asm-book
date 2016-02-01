# power function, following platform ABI

.section .text
# power(n, m) -> n ^ m (m >= 0)
.globl power
power:
pushl %ebp
movl %esp, %ebp
# store esi (ABI requires it to be preserved)
#   can't use edx as it will get clobbered during imul later
pushl %esi
# load n
movl 0x8(%ebp), %esi
# load m
movl 0xc(%ebp), %ecx
# initialize result
movl $1, %eax
.Lloop:
test %ecx, %ecx
jz .Ldone
decl %ecx
# eax:edx = eax * esi
imull %esi
jmp .Lloop
.Ldone:
popl %esi
# = movl %ebp, %esp; popl %ebp
leave
ret

.globl _start
_start:
pushl $7
pushl $2
# calculate 2 ^ 7
call power
# pop arguments off stack
addl $0x8, %esp
# exit
movl %eax, %ebx
movl $1, %eax
pushl $0 # bogus return address
pushl %ecx
pushl %edx
pushl %ebp
movl %esp, %ebp
sysenter