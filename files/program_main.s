	.file	"program_main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
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
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	cmp	DWORD PTR -84[rbp], 1
	jne	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -48[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	jmp	.L3
.L2:
	cmp	DWORD PTR -84[rbp], 2
	jne	.L4
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edi, eax
	call	generatePositiveDouble@PLT
	movq	rax, xmm0
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	jmp	.L3
.L4:
	cmp	DWORD PTR -84[rbp], 3
	jne	.L5
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	lea	rdx, -48[rbp]
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	jmp	.L3
.L5:
	mov	eax, -1
	jmp	.L15
.L3:
	movsd	xmm1, QWORD PTR -48[rbp]
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	jbe	.L17
	cmp	DWORD PTR -84[rbp], 3
	jne	.L9
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	mov	rcx, rax
	mov	edx, 10
	mov	esi, 1
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	fwrite@PLT
	jmp	.L10
.L9:
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	puts@PLT
.L10:
	mov	eax, 0
	jmp	.L15
.L17:
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	DWORD PTR -12[rbp], 0
	jmp	.L11
.L12:
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rax
	call	sqrt@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	add	DWORD PTR -12[rbp], 1
.L11:
	cmp	DWORD PTR -12[rbp], 19999999
	jle	.L12
	lea	rax, -80[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	mov	rdx, QWORD PTR -72[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	calculateElapsedTime@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -84[rbp], 3
	jne	.L13
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC9[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	jmp	.L14
.L13:
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC10[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
.L14:
	mov	eax, 0
.L15:
	leave
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
