# max function, suitable for calling from C etc.
#   follows SysV i386 ABI, including save/restore of requisite registers

.section .data
items:
# zero-terminated list of things
.long 17,199,253,172,193,0

.section .text
# max(list) -> maximum
.globl max
max:
# push current base pointer onto stack
# the following two lines can be written using
#   the enter instruction, but it'd be slower
pushl %ebp
movl %esp, %ebp
# store ABI preserve-required registers which we intend to clobber
#   we must always preserve ebx, esi, edi, ebp, esp
#   we can scribble in eax, ecx, edx
#   I could use, say, ecx and edx instead of ebx and esi here
#     and probably should, but this demonstrates pushing and popping
#     registers on function call and return
# set base pointer to current stack pointer
pushl %ebx
pushl %esi
# function arguments are lower on stack
#   i.e. positive offsets to ebp
movl 8(%ebp), %esi
movl $0x80000000, %ebx
# use GAS local labels
1:
movl (%esi), %eax
test %eax, %eax
# if eax == 0
jz 2f
addl $4, %esi
cmpl %ebx, %eax
# if eax <= ebx
jle 1b
# else
movl %eax, %ebx
jmp 1b
2:
movl %ebx, %eax
popl %esi
popl %ebx
# the following three lines can also be written as the precisely equivalent
#   leave
#   ret
# which may not be faster, but is smaller (it shouldn't be slower)
movl %ebp, %esp
popl %ebp
ret
