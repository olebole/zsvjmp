
# Copyright 2018 Gustavo Romero, Rogerio Cardoso, Breno Leitao, IBM Corporation.

	.file "zsvjmp.s"
	.abiversion 2
	.section ".text"
	.align 2
	.globl zsvjmp_
	.type zsvjmp_, @function

# The idea here is to use VRSAVE, a 32-bit register, and reserved area at SP+12
# (a padding unsed area) to save the LR register which is lost after calling
# __sigsetjmp with 'bl'. Note that such a function cannot be called using simple
# 'b' because it resides in a shared object and linker will complain about not
# finding the sequence 'bl <f>; nop;". VRSAVE although in the ABI is not used on
# Linux and is so set by the kernel to 0xffffffff (-1) since a few libc function
# use just as boolean. However in this case VRSAVE value is destroy just before
# calling __sigsetjmp that does not rely on VRSAVE even as boolean. __sigsetjmp
# just saves the VRSAVE in the context buffer. Once zdojmp triggers the context
# restoration it restores the VRSAVE incorrect value as well (it still contains
# the LR LSB value), but once again VRSAVE is fixed by setting it again to -1
# before returnin and if any function tries to use it ahead it's correctly set
# as "true".

#define r1  %r1
#define r3  %r3
#define r4  %r4
#define r10 %r10
#define r11 %r11
#define r14 %r14
#define cr0 0

zsvjmp_:
	# r3 = buf, r4 = &status

	xor   r11, r11, r11   # zero r11
	std   r11, 0(r4)      # *status = 0
	std   r4,  0(r3)      # *(buf + 0) = status
	addi  r3, r3, 8       # r3 = buf + 8
	mr    r4, r11         # r4 = 0

	mflr  r11	      # save LR
	mtvrsave r11          # LR LSB to VRSAVE
	srdi r11, r11, 32     # LR MSB to SP+12 (reserved)
	stw  r11, 12(r1)

	bl    __sigsetjmp
	nop

	lwz r11, 12(r1)       # restore LR
	sldi r11, r11, 32
	mfvrsave r10
	add r11, r11, r10
	mtlr r11

	li r11, -1            # restore VRSAVE
	mtvrsave r11

	blr
	.size	zsvjmp_,.-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
