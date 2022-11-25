	.intel_syntax noprefix

	.text
	.globl	sqrt
sqrt:						# Функция sqrt
	push	rbp				# Пролог функции
	mov	rbp, rsp

	movsd	xmm2, xmm0			# Загрузка x (x в xmm2)

	pxor	xmm0, xmm0			# Сравнение x с нулем
	ucomisd	xmm0, xmm2
	jne	.L2

	pxor	xmm0, xmm0			# Возвращение нуля
	jmp	.L4

.L2:
	movsd	xmm3, QWORD PTR .LC1[rip]	# Загрузка константы 1.0 в result (result в xmm3)
	movsd	xmm4, QWORD PTR .LC1[rip]	# Загрузка константы 1.0 в next (result в next)

.L5:
	movsd	xmm3, xmm4			# result = next

	movsd	xmm0, xmm2			# next = 0.5 * (result  + (x / result))
	divsd	xmm0, xmm3
	movapd	xmm1, xmm0
	addsd	xmm1, xmm3
	movsd	xmm0, QWORD PTR .LC2[rip]	# Загрузка константы 0.5
	mulsd	xmm0, xmm1
	movsd	xmm4, xmm0

	ucomisd	xmm4, xmm3			# Выход из цикла
	je	.L8

	jmp	.L5

.L8:
	movsd	xmm0, xmm3

.L4:
	pop	rbp				# Эпилог функции
	ret

	.globl	generatePositiveDouble
generatePositiveDouble:				# Функция generatePositiveDouble
	push	rbp				# Пролог функции
	mov	rbp, rsp
	sub	rsp, 16
	
	call	srand@PLT			# srand(seed)
	
	call	rand@PLT			# Вызов rand()
	
	cvtsi2sd	xmm0, eax		# Перевод результата rand() в double
	
	movsd	xmm2, QWORD PTR .LC3[rip]	# Загрузка константы RAND_MAX

	movapd	xmm1, xmm0			# Деление rand() на RAND_MAX
	divsd	xmm1, xmm2
	
	movsd	xmm0, QWORD PTR .LC4[rip]	# Загрузка константы 100.0

	mulsd	xmm0, xmm1			# Умножение на 100.0

	leave					# Эпилог функции
	ret

	.globl	calculateElapsedTime
calculateElapsedTime:
	imul	rdx, rdx, 1000000000		# ns1 *= 1000000000
	
	imul	rdi, rdi, 1000000000		# ns2 *= 1000000000
	
	add	rdx, rcx			# ns1 += t1.tv_nsec
	
	add	rdi, rsi			# ns2 += t2.tv_nsec
	
	mov	rax, rdx			# ns2 - ns1
	sub	rax, rdi

	ret					# Эпилог функции

	.section	.rodata			# Константы

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
