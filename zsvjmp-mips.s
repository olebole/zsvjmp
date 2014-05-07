	.file	"zsvjmp.s"
;; Thanks to David Kuehling <dvdkhlng@posteo.de>
;; https://lists.debian.org/debian-mips/2014/05/msg00021.html
;; This file contains the Linux MIPS/MIPSEL version of ZSVJMP
;; for Debian (oabi32).
	.section	".text"
	.globl zsvjmp_
	.type	zsvjmp_, @function
zsvjmp_:
	sw  $a1, 0($a0)
	sw  $zero, 0($a1)
	addiu  $a0, $a0, 4
	move    $a1, $zero
	la      $t9, __sigsetjmp
	jr      $t9
	.size	zsvjmp_,.-zsvjmp_
	.section	.note.GNU-stack,"",@progbits
