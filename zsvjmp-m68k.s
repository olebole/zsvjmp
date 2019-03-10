	# Untested
	# generated with gcc -O2 -S from the C source
	.file	"zsvjmp.s"
	.text
	.align	2
	.globl	zsvjmp_
	.type	zsvjmp_, @function
zsvjmp_:
	move.l 8(%sp),%a1
	clr.l (%a1)
	move.l 4(%sp),%a0
	move.l %a1,(%a0)+
	clr.l 8(%sp)
	move.l %a0,4(%sp)
	jra sigsetjmp

	.size	zsvjmp_, .-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
