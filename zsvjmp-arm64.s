	.file	"zsvjmp.s"

@ Copyright (c) 2017 Peter Green
@ Distributable under the same license as IRAF
@ This file contains the Linux armel/armhf version of ZSVJMP for Debian.

	.arch armv8-a
	.text
	.global	zsvjmp_
	.type	zsvjmp_, %function

zsvjmp_:
        str     xzr, [x1]       # *status = 0;
        str     x1, [x0], 8     # ((long **)buf)[0] = status;
	# also post-increment x0 by 8 for first parameter of __sigsetjmp
        mov     w1, 0           # set w1 to zero, w1 forms the second parameter of __sigsetjmp
        b      __sigsetjmp     # call sigsetjmp

