	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text
	.globl	sqrt
	.type	sqrt, @function
sqrt:
	endbr64
	xorps	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jp	.L7
	movaps	xmm2, xmm1
	je	.L1
.L7:
	movsd	xmm1, QWORD PTR .LC0[rip]
	movsd	xmm4, QWORD PTR .LC2[rip]
.L8:
	movaps	xmm3, xmm0
	movaps	xmm2, xmm1
	divsd	xmm3, xmm1
	addsd	xmm3, xmm1
	mulsd	xmm3, xmm4
	ucomisd	xmm2, xmm3
	movaps	xmm1, xmm3
	jp	.L8
	jne	.L8
.L1:
	movaps	xmm0, xmm2
	ret
	.size	sqrt, .-sqrt
	.globl	generatePositiveDouble
	.type	generatePositiveDouble, @function
generatePositiveDouble:
	endbr64
	push	rax
	call	srand@PLT
	call	rand@PLT
	cvtsi2sd	xmm0, eax
	divsd	xmm0, QWORD PTR .LC3[rip]
	mulsd	xmm0, QWORD PTR .LC4[rip]
	pop	rdx
	ret
	.size	generatePositiveDouble, .-generatePositiveDouble
	.globl	calculateElapsedTime
	.type	calculateElapsedTime, @function
calculateElapsedTime:
	endbr64
	imul	rdx, rdx, 1000000000
	imul	rdi, rdi, 1000000000
	add	rdx, rcx
	add	rdi, rsi
	mov	rax, rdx
	sub	rax, rdi
	ret
	.size	calculateElapsedTime, .-calculateElapsedTime
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	1071644672
	.align 8
.LC3:
	.long	-4194304
	.long	1105199103
	.align 8
.LC4:
	.long	0
	.long	1079574528
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
