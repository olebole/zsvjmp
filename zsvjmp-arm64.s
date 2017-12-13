	.file	"zsvjmp.s"

@ Copyright (c) 2014 Ole Streicher <debian@liska.ath.cx>
@ Distributable under the same license as IRAF
@ This file contains the Linux arm64 version of ZSVJMP for Debian.

	.arch armv8-a
        .text
        .align  2
        .global zsvjmp_
        .type   zsvjmp_, %function

zsvjmp_:
	stp     x29, x30, [sp, -32]!
        add     x29, sp, 0
        str     x0, [x29, 24]
        str     x1, [x29, 16]
        ldr     x0, [x29, 16]
        str     xzr, [x0]
        ldr     x0, [x29, 24]
        ldr     x1, [x29, 16]
        str     x1, [x0]
        ldr     x0, [x29, 24]
        add     x0, x0, 8     @ &buf[1] --> 1st arg for sigsetjmp
        str     x0, [x29, 24]
        mov     w1, 0         @ 0       --> 2nd arg for sigsetjmp
        ldr     x0, [x29, 24]
	
        b	__sigsetjmp   @ call sigsetjmp
