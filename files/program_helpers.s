	.file	"program_helpers.c"
	.intel_syntax noprefix
	.text
	.globl	sqrt
	.type	sqrt, @function
sqrt:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -24[rbp], xmm0
	pxor	xmm0, xmm0
	ucomisd	xmm0, QWORD PTR -24[rbp]
	jp	.L2
	pxor	xmm0, xmm0
	ucomisd	xmm0, QWORD PTR -24[rbp]
	jne	.L2
	pxor	xmm0, xmm0
	jmp	.L4
.L2:
	movsd	xmm0, QWORD PTR .LC1[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC1[rip]
	movsd	QWORD PTR -8[rbp], xmm0
.L5:
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	divsd	xmm0, QWORD PTR -16[rbp]
	movapd	xmm1, xmm0
	addsd	xmm1, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	ucomisd	xmm0, QWORD PTR -16[rbp]
	jp	.L5
	movsd	xmm0, QWORD PTR -8[rbp]
	ucomisd	xmm0, QWORD PTR -16[rbp]
	je	.L8
	jmp	.L5
.L8:
	movsd	xmm0, QWORD PTR -16[rbp]
.L4:
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	sqrt, .-sqrt
	.globl	generatePositiveDouble
	.type	generatePositiveDouble, @function
generatePositiveDouble:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	mov	eax, DWORD PTR -4[rbp]
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	movsd	xmm2, QWORD PTR .LC3[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR .LC4[rip]
	mulsd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	generatePositiveDouble, .-generatePositiveDouble
	.globl	calculateElapsedTime
	.type	calculateElapsedTime, @function
calculateElapsedTime:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	calculateElapsedTime, .-calculateElapsedTime
	.section	.rodata
	.align 8
.LC1:
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
