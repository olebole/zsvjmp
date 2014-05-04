	.file	"zsvjmp.s"
        .globl	zsvjmp_
	.type   zsvjmp_, @function
	
zsvjmp_:
	# %rsi ... &status  %rdi ... &jumpbuf
	movq    %rsi, (%rdi)    # store &status in jmpbuf[0]
	movl    $0, (%rsi)      # zero the value of status
	addq    $8, %rdi        # change point to &jmpbuf[1]
	movl    $0, %esi        # change arg2 to zero
	jmp     __sigsetjmp@PLT    # let sigsetjmp do the rest

	.section        .note.GNU-stack,"",@progbits
