	.file	"program_main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Input number: "
.LC1:
	.string	"%lf"
.LC2:
	.string	"Generated number: %lf\n"
.LC3:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"undefined\n"
.LC7:
	.string	"Result: undefined"
.LC8:
	.string	"Elapsed: %ld ns\n"
.LC9:
	.string	"%lf\n"
.LC10:
	.string	"Result: %lf\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	endbr64
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	ebx, edi
	sub	rsp, 64
	dec	edi
	jne	.L2
	lea	rsi, .LC0[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, 24[rsp]
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
	jmp	.L3
.L2:
	cmp	ebx, 2
	jne	.L4
	mov	rdi, QWORD PTR 8[rsi]
	call	atoi@PLT
	mov	edi, eax
	call	generatePositiveDouble@PLT
	lea	rsi, .LC2[rip]
	mov	edi, 1
	mov	al, 1
	movsd	QWORD PTR 24[rsp], xmm0
	call	__printf_chk@PLT
	jmp	.L3
.L4:
	or	eax, -1
	cmp	ebx, 3
	jne	.L1
	mov	rdi, QWORD PTR 8[rsi]
	lea	rsi, .LC3[rip]
	call	fopen@PLT
	lea	rdx, 24[rsp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
.L3:
	xorps	xmm0, xmm0
	comisd	xmm0, QWORD PTR 24[rsp]
	jbe	.L16
	cmp	ebx, 3
	jne	.L8
	mov	rdi, QWORD PTR 16[rbp]
	lea	rsi, .LC5[rip]
	call	fopen@PLT
	lea	rdi, .LC6[rip]
	mov	rsi, rax
	call	fputs@PLT
	jmp	.L11
.L8:
	lea	rdi, .LC7[rip]
	call	puts@PLT
	jmp	.L11
.L16:
	lea	rsi, 32[rsp]
	mov	edi, 1
	mov	r12d, 20000000
	call	clock_gettime@PLT
.L9:
	movsd	xmm0, QWORD PTR 24[rsp]
	call	sqrt@PLT
	dec	r12d
	jne	.L9
	lea	rsi, 48[rsp]
	mov	edi, 1
	movsd	QWORD PTR 8[rsp], xmm0
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR 48[rsp]
	mov	rcx, QWORD PTR 56[rsp]
	mov	rdi, QWORD PTR 32[rsp]
	mov	rsi, QWORD PTR 40[rsp]
	call	calculateElapsedTime@PLT
	lea	rsi, .LC8[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	cmp	ebx, 3
	movsd	xmm0, QWORD PTR 8[rsp]
	jne	.L10
	mov	rdi, QWORD PTR 16[rbp]
	lea	rsi, .LC5[rip]
	call	fopen@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	mov	esi, 1
	lea	rdx, .LC9[rip]
	mov	rdi, rax
	mov	al, 1
	call	__fprintf_chk@PLT
	jmp	.L11
.L10:
	lea	rsi, .LC10[rip]
	mov	edi, 1
	mov	al, 1
	call	__printf_chk@PLT
.L11:
	xor	eax, eax
.L1:
	add	rsp, 64
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	main, .-main
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
