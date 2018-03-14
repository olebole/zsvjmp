	.file	"zsvjmp.s"
        .globl	zsvjmp_
	.type   zsvjmp_, @function
	
zsvjmp_:
	# %esi ... &status  %edi ... &jumpbuf
	movl    %esi, (%edi)    # store &status in jmpbuf[0]
	movl    $0, (%esi)      # zero the value of status
	addl    $4, %edi        # change point to &jmpbuf[1]
	movl    $0, %esi        # change arg2 to zero
	jmp     __sigsetjmp@PLT    # let sigsetjmp do the rest

	.section        .note.GNU-stack,"",@progbits
