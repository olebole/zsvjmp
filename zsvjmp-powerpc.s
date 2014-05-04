	.file	"zsvjmp.s"

# Copyright (c) 2014 Ole Streicher <debian@liska.ath.cx>
# Distributable under the same license as IRAF
# This file contains the Linux Powerpc version of ZSVJMP for Debian.

	.section	".text"
	.align 2
	.globl zsvjmp_
	.type	zsvjmp_, @function
zsvjmp_:
	li 9,0          #
	stw 9,0(4)      # *status = 0
	stw 4,0(3)      # buf[0] = status
	addi 3,3,4      # &buf[1] --> 1st arg for sigsetjmp
	li 4,0          # 0       --> 2nd arg for sigsetjmp
	b __sigsetjmp
	.size	zsvjmp_,.-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
