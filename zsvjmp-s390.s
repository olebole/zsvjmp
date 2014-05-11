	.file	"zsvjmp.s"

# Copyright (c) 2014 John Long <codeblue@inbox.lv>
# Distributable under the same license as IRAF
# This file contains the Linux s390 (31 bit) version of ZSVJMP for Debian.

	.text
	.global	zsvjmp_
	.type	zsvjmp_, %function

zsvjmp_:
        st      %r3,0(0,%r2)         # save contents of r3 where r2 is pointing
	xc      0(4,%r3),0(%r3)      # clear fullword where r3 is pointing
	xr      %r3,%r3              # clear r3
	ahi     %r2,8                # r2 <- r2 + 8
	j	__sigsetjmp@PLT      # load vcon resolved by linker

	.size	zsvjmp_, .-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
