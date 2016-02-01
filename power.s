# power function, following platform ABI
.section .data
.Lformatstr:
.asciz "%d ^ %d = %d\n"

.section .text
# power(n, m) -> n ^ m (m >= 0)
.globl power
.type power, @function
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

# calculate 2 ^ 7
pushl $7
pushl $2
call power
# pop arguments off stack
addl $0x8, %esp
# call printf
pushl %eax
pushl $7
pushl $2
pushl $.Lformatstr
call printf
addl $0x10, %esp

# calculate (-4 ^ 3)
pushl $3
pushl $-4
call power
# pop arguments off stack
addl $0x8, %esp
# call printf
pushl %eax
pushl $3
pushl $-4
pushl $.Lformatstr
call printf
addl $0x10, %esp

# calculate 3 ^ 0
pushl $0
pushl $3
call power
# pop arguments off stack
addl $0x8, %esp
# call printf
pushl %eax
pushl $0
pushl $3
pushl $.Lformatstr
call printf
addl $0x10, %esp

# exit
movl $1, %eax
xor %ebx, %ebx
pushl $0 # bogus return address
pushl %ecx
pushl %edx
pushl %ebp
movl %esp, %ebp
sysenter
