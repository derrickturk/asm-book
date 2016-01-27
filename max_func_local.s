# find max, using a function, with a local variable

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
# allocate a ptr-sized local variable on the stack
#   which will store the current max
#   (we use ebp for this in max_func.s)
subl $4, %esp
# function arguments are lower on stack
#   i.e. positive offsets to ebp
movl 8(%ebp), %esi
# locals are higher on stack
#   i.e. negative offsets to ebp
movl $0x80000000, -4(%ebp)
# .L prefixed symbols are local; they won't be emitted
#   in the resulting object file
# .L is an ELF-specific prefix; this can also be accomplished
#   with GAS local labels (i.e. 1: ... jle 1b)
.Lloop:
movl (%esi), %eax
test %eax, %eax
# if eax == 0
jz .Ldone
addl $4, %esi
cmpl -4(%ebp), %eax
# if eax <= max
jle .Lloop
# else
movl %eax, -4(%ebp)
jmp .Lloop
.Ldone:
movl -4(%ebp), %eax
# here we blow away locals; no need to addl $4, %esp
#   because we directly restore the value at function entry
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
