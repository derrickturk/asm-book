	.file	"max.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.section	.text.startup,"ax",@progbits
.LHOTB0:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	movl	items, %edx
	testl	%edx, %edx
	je	.L4
	movl	$items, %ecx
	movl	$-2147483648, %eax
	.p2align 4,,10
	.p2align 3
.L3:
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	addl	$4, %ecx
	movl	(%ecx), %edx
	testl	%edx, %edx
	jne	.L3
	rep ret
.L4:
	movl	$-2147483648, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE0:
	.section	.text.startup
.LHOTE0:
	.globl	items
	.data
	.align 4
	.type	items, @object
	.size	items, 24
items:
	.long	17
	.long	199
	.long	253
	.long	172
	.long	193
	.long	0
	.ident	"GCC: (GNU) 5.3.1 20151207 (Red Hat 5.3.1-2)"
	.section	.note.GNU-stack,"",@progbits
