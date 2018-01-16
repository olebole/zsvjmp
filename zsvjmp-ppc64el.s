	.file	"zsvjmp.s"

	.abiversion 2
	.section	".text"
	.align 2
	.globl zsvjmp_
	.type	zsvjmp_, @function
zsvjmp_:
	# R3 = buf, R4 = &status
	li   11,0        # r11 = 0
	std  11,0(4)     # *status = r11
	std  4,0(3)      # buf[0] = status (as arg)
	addi 3,3,8       # &buf[1] --> 1st arg for sigsetjmp (Buf)
	li   4,0         # 0       --> 2nd arg for sigsetjmp (savesigs)
	mflr 11
	std  11, -8(1)     # Save on the read zone
	addi 1, 1, -8    # create a small frame
	bl    __sigsetjmp
	nop
	ld 11, 0(1)     # Recover from the read zone
	mtlr 11		# Restore lr
	addi 1, 1, 8    # Remove our mini frame
	blr
	.size	zsvjmp_,.-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
