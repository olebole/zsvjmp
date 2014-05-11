	.file	"zsvjmp.s"

	.section	".text"
	.align 2
	.globl zsvjmp_
	.type	zsvjmp_, @function
zsvjmp_:
	# R3 = buf, R4 = &status
	li 11,0         #
	stw 11,0(4)     # *status = 0
	stw 4,0(3)      # buf[0] = status
	addi 3,3,4      # &buf[1] --> 1st arg for sigsetjmp
	li 4,0          # 0       --> 2nd arg for sigsetjmp
	b __sigsetjmp@PLT
	.size	zsvjmp_,.-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
