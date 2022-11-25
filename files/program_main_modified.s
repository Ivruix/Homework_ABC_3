	.intel_syntax noprefix
	.text

	.section	.rodata			# Строки для main
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
main:						# Функция main
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 96

	mov	r12d, edi			# Загрузка argc (argc в r12d)
	mov	r13, rsi			# Загрузка argv (argv в r13)

	cmp	r12d, 1				# Проверка количетва параметров консоли
	jne	.L2

	lea	rdi, .LC0[rip]			# printf("Input number: ")
	mov	eax, 0
	call	printf@PLT

	lea	rsi, -48[rbp]			# scanf("%lf", &x) (x в -48[rbp])
	lea	rdi, .LC1[rip]			# Передача строки
	mov	eax, 0
	call	__isoc99_scanf@PLT

	jmp	.L3

.L2:
	cmp	r12d, 2				# Проверка количетва параметров консоли
	jne	.L4

	mov	rax, r13			# atoi(argv[1])
	add	rax, 8
	mov	rdi, QWORD PTR [rax]		# Передача argv[1]
	call	atoi@PLT
	
	mov	edi, eax			# x = generatePositiveDouble(atoi(argv[1]))
	call	generatePositiveDouble@PLT
	movq	QWORD PTR -48[rbp], xmm0

	movq	xmm0, QWORD PTR -48[rbp]	# printf("Generated number: %lf\n", x)
	lea	rdi, .LC2[rip]			# Передача строки
	mov	eax, 1
	call	printf@PLT

	jmp	.L3

.L4:
	cmp	r12d, 3				# Проверка количетва параметров консоли
	jne	.L5

	mov	rax, r13			# fopen(argv[1], "r")
	add	rax, 8
	mov	rax, QWORD PTR [rax]		# Передача argv[1]
	lea	rdx, .LC3[rip]			# Передача строки
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT

	lea	rdx, -48[rbp]			# fscanf(input, "%lf", &x)
	lea	rcx, .LC1[rip]			# Передача строки
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT

	jmp	.L3

.L5:
	mov	eax, -1				# Возврат -1
	jmp	.L15

.L3:
	pxor	xmm0, xmm0			# Проверка x на неотрицательность
	comisd	xmm0, QWORD PTR -48[rbp]
	jbe	.L17

	cmp	r12d, 3				# Проверка количетва параметров консоли
	jne	.L9

	mov	rax, r13			# fopen(argv[2], "w")
	add	rax, 16
	mov	rax, QWORD PTR [rax]		# Передача argv[2]
	lea	rdx, .LC5[rip]			# Передача строки
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT

	mov	rcx, rax			# fprintf(output, "undefined\n")
	mov	edx, 10
	mov	esi, 1
	lea	rdi, .LC6[rip]			# Передача строки
	call	fwrite@PLT

	jmp	.L10

.L9:
	lea	rax, .LC7[rip]			# printf("Result: undefined\n")
	mov	rdi, rax
	call	puts@PLT

.L10:
	mov	eax, 0				# Возврат 0
	jmp	.L15

.L17:
	lea	rsi, -64[rbp]			# clock_gettime(CLOCK_MONOTONIC, &t1)
	mov	edi, 1
	call	clock_gettime@PLT

	mov	r14d, 0				# i = 0 (i в r14d)
	jmp	.L11

.L12:
	movq	xmm0, QWORD PTR -48[rbp]	# result = sqrt(x) (result в xmm5)
	call	sqrt@PLT
	movq	xmm5, xmm0			# Сохранение результата
	
	add	r14d, 1				# i++

.L11:
	cmp	r14d, 19999999			# Выход из цикла
	jle	.L12

	lea	rsi, -80[rbp]			# clock_gettime(CLOCK_MONOTONIC, &t2);
	mov	edi, 1
	call	clock_gettime@PLT

	mov	rax, QWORD PTR -80[rbp]		# elapsed_time = calculateElapsedTime(t1, t2)
	mov	rdx, QWORD PTR -72[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	calculateElapsedTime@PLT

	mov	rsi, rax			# printf("Elapsed: %ld ns\n", elapsed_time)
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT

	cmp	r12d, 3				# Проверка количетва параметров консоли
	jne	.L13

	mov	rax, r13			# fopen(argv[2], "w")
	add	rax, 16
	mov	rax, QWORD PTR [rax]		# Передача argv[2]
	lea	rdx, .LC5[rip]			# Передача строки
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT

	movq	xmm0, xmm5			# fprintf(output, "%lf\n", result)
	lea	rdx, .LC9[rip]			# Передача строки
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT

	jmp	.L14

.L13:
	movq	xmm0, xmm5			# printf("Result: %lf\n", result)
	lea	rax, .LC10[rip]			# Передача строки
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT

.L14:
	mov	eax, 0				# Возврат 0

.L15:
	leave					# Эпилог функции
	ret
