.section .data
items:
# zero-terminated list of things
.long 17,199,253,172,193,0

.section .text
# max(list) -> maximum
max:
# push current base pointer onto stack
pushl %ebp
# set base pointer to current stack pointer
movl %esp, %ebp
# function arguments are lower on stack
#   i.e. positive offsets to ebp
movl 8(%ebp), %esi
movl $0x80000000, %ebx
loop:
movl (%esi), %eax
test %eax, %eax
# if eax == 0
jz done
addl $4, %esi
cmpl %ebx, %eax
# if eax <= ebx
jle loop
# else
movl %eax, %ebx
jmp loop
done:
movl %ebx, %eax
movl %ebp, %esp
popl %ebp
ret

.global _start
_start:
pushl $items
call max
# "pop" $items off stack and discard
#   (equivalent to pop but without saving to register)
addl $4, %esp
movl %eax, %ebx
movl $1, %eax
int $0x80
