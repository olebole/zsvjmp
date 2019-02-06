#if defined(__alpha__)
// Based in original (DEC ALPHA/OSF), but registers replaced from <regdef.h>
// Copyright 1994 AURA/NOAO

	.text
	.align  2
	.file	"zsvjmp.s"
	.globl	zsvjmp_
zsvjmp_:				// $16=jmpbuf, $17=status
	mov	$29, $8			// save caller's global pointer
	ldgp	$29, 4($27)		// needed for setjmp reference

	stq	$17, 0($16)		// jmpbuf[0] = status
	stl	$31, 0($17)		// *status = 0
	addq	$16, 8, $16		// setjmp ignores jmpbuf[0]

	lda	$27, setjmp		// get address of setjmp
	mov	$8, $29			// restore caller's global pointer
	jmp	($27)			// branch to setjmp
#endif
