	.file	"zsvjmp.s"
	.text
        .globl	zsvjmp_
	.type   zsvjmp_, @function

zsvjmp_:
	movl	4(%esp), %ecx		# &jmpbuf to ECX
	movl	8(%esp), %eax		# &status to EAX
	movl	%eax, (%ecx)		# store &status in jmpbuf[0]
	movl 	$0, (%eax)		# zero the value of status
	addl	$4, %ecx		# change stack to point to &jmpbuf[1]
	movl	%ecx, 4(%esp)		# 	...
	movl	$0, 8(%esp)		# change arg2 to zero
	jmp	__sigsetjmp@PLT		# let sigsetjmp do the rest

	.size	zsvjmp_, .-zsvjmp_
	.section        .note.GNU-stack,"",@progbits
