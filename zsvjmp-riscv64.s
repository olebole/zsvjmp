	.file   "zsvjmp.s"

	# From a discussion on the linux-riscv list, see
	# https://lists.debian.org/debian-riscv/2018/10/msg00012.html

	.text
        .globl  zsvjmp_
        .type   zsvjmp_, @function

zsvjmp_:
	sd      zero,0(a1)
        sd      a1,0(a0)
        li      a1,0
        addi    a0,a0,8
        tail    __sigsetjmp@plt

        .size   zsvjmp_,.-zsvjmp_
