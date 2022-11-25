	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	sqrt
	.type	sqrt, @function
sqrt:
	endbr64
	pxor	xmm5, xmm5
	ucomisd	xmm0, xmm5
	jp	.L7
	pxor	xmm3, xmm3
	je	.L1
.L7:
	movsd	xmm1, QWORD PTR .LC0[rip]
	movsd	xmm4, QWORD PTR .LC2[rip]
	.p2align 4,,10
	.p2align 3
.L8:
	movapd	xmm2, xmm0
	movapd	xmm3, xmm1
	divsd	xmm2, xmm1
	addsd	xmm2, xmm1
	movapd	xmm1, xmm2
	mulsd	xmm1, xmm4
	ucomisd	xmm3, xmm1
	jp	.L8
	jne	.L8
.L1:
	movapd	xmm0, xmm3
	ret
	.size	sqrt, .-sqrt
	.p2align 4
	.globl	generatePositiveDouble
	.type	generatePositiveDouble, @function
generatePositiveDouble:
	endbr64
	sub	rsp, 8
	call	srand@PLT
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	divsd	xmm0, QWORD PTR .LC3[rip]
	mulsd	xmm0, QWORD PTR .LC4[rip]
	add	rsp, 8
	ret
	.size	generatePositiveDouble, .-generatePositiveDouble
	.p2align 4
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
