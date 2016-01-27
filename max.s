.section .data
items:
# zero-terminated list of things
.long 17,199,253,172,193,0

.section .text
.global _start
_start:
# the book uses edi here, but according to a
#   random internet man edi is the DESTINATION index and
#   we're really using it here as a SOURCE index, which esi
#   is (allegedly) intended to be
movl $0, %esi
movl $0x80000000, %ebx
loop:
# indexed addressing mode
#   segment:displacement(base register,index,multiplier)
movl items(,%esi,4), %eax
cmpl $0, %eax
# if eax == 0
je done
incl %esi
cmpl %ebx, %eax
# if eax <= ebx
jle loop
# else
movl %eax, %ebx
jmp loop
done:
movl $1, %eax
# ebx (max) will be exit code
int $0x80
