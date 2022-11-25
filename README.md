
# Отчёт по ИДЗ 3

## Об отчёте

**Выполнил:** Каверин Максим Вячеславович

**Группа:** БПИ217

**Вариант:** 18

**Задание:** Разработать программу вычисления корня квадратного по итерационной формуле Герона Александрийского с точностью не хуже 0,05%.

Данный отчёт разбит на блоки по оценкам для удобства проверки. Программа была разработана с учетом требований до оценки 9 включительно.

Все файлы, относящиеся к решению, находятся в папке **files**.

Тесты находятся в папке **tests**.

## Код программы на C и ассемблере

Для решения задачи были написаны файлы **program_main.c** и **program_helpers.c**.

 **program_main.c**:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern double sqrt(double x);
extern double generatePositiveDouble(int seed);
extern int64_t calculateElapsedTime(struct timespec t1, struct timespec t2);

int main(int argc, char** argv) {
    double x, result;
    FILE *input, *output;
    struct timespec t1;
    struct timespec t2;
    int64_t elapsed_time;
    
    if (argc == 1) {
        printf("Input number: ");
        scanf("%lf", &x);
    } else if (argc == 2) {
        x = generatePositiveDouble(atoi(argv[1]));
        printf("Generated number: %lf\n", x);
    } else if (argc == 3) {
        input = fopen(argv[1], "r");
        fscanf(input, "%lf", &x);
    } else {
        return -1;
    }
    
    if (x < 0.0) {
        if (argc == 3) {
            output = fopen(argv[2], "w");
            fprintf(output, "undefined\n");
        } else {
            printf("Result: undefined\n");
        }
        
        return 0;
    }
    
    clock_gettime(CLOCK_MONOTONIC, &t1);
    
    for (int i = 0; i < 20000000; i++) {
        result = sqrt(x);
    }
    
    clock_gettime(CLOCK_MONOTONIC, &t2);
    
    elapsed_time = calculateElapsedTime(t1, t2);
    printf("Elapsed: %ld ns\n", elapsed_time);
    
    if (argc == 3) {
        output = fopen(argv[2], "w");
        fprintf(output, "%lf\n", result);
    } else {
        printf("Result: %lf\n", result);
    }
}
```

 **program_helpers.c**:
 
```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

extern double sqrt(double x) {
    double result, next;
    
    if (x == 0.0) {
    	return 0.0;
    }
    
    result = 1.0;
    next = 1.0;
    
    do {
        result = next;
        next = 0.5 * (result  + (x / result));
    } while (next != result);
    
    return result;
}

double generatePositiveDouble(int seed) {
    srand(seed);
    return (((double) rand()) / RAND_MAX) * 100.0;
}

int64_t calculateElapsedTime(struct timespec t1, struct timespec t2) {
    int64_t ns1, ns2;

    ns1 = t1.tv_sec;
    ns1 *= 1000000000;
    ns1 += t1.tv_nsec;


    ns2 = t2.tv_sec;
    ns2 *= 1000000000;
    ns2 += t2.tv_nsec;

    return ns2 - ns1;
}
```

После компиляции и внесения изменений, описанных в следующих пунктах, получились файлы **program_main_modified.s** и **program_helpers_modified.s**.

**program_main_modified.s**:

```gas
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
```

**program_helpers_modified.s**:

```gas
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
```

## На оценку 4

- Программы были скомпилированы без оптимизирующих и отладочных опций, получились файлы **program_helpers.s** и **program_main.s**.
- Были добавлены комментарии.
- Были убраны лишние макросы (по типу endbr64, nop, cdqe, movsx).
- Получившиеся файлы были ассемблированы и скомпонованы. Получились файлы **program.out** и **program_modified.out**. 
- Исполняемые файлы были проверены на тестах из папки **tests**. Результаты обоих программ во всех случаях одинаковые и верные.

## На оценку 5

- Были использованы функции с передаче параметров (например, calculateElapsedTime).
- Были использованы локальные переменные (например, result в main).
- Комментарии уже были добавлены.

## На оценку 6

- Был произведен рефакторинг для максимизирования использования регистров процессора (например, argc и argv были перемещены в r12d и r13, соответственно).
- Были оптимизированы конструкции, в которых запись в регистр происходит через предварительную запись в другой регистр.
- Программа уже была проверена на тестах.
- Суммарный размер объектных файлов модифицированной программы равен `3832 B`, что меньше, чем изначальные `4816 B`.
- Размер модифицированной программы равен `16384 B`, что меньше, чем изначальные `16536 B`.

## На оценку 7 и 8

 - Код был разбит на 2 единицы компиляции.
 - Был реализован следующий функционал:
	 - Задание файлов ввода и вывода (происходит, если в командной строке два параметра, это пути до файла ввода и вывода соответственно).
	 - Задание случайного входного числа (происходит, если в командной строке один параметр, это seed).
	 - Измерение времени выполнения программы.

- Программа была протестирована по времени:

|     Входное число    | Время выполнения |
|----------------------|------------------|
|           0          |      0.036 s     |
|          10          |      0.373 s     |
|         1e4          |      0.895 s     |
|         1e6          |      1.324 s     |

## На оценку 9

### Оптимизация по скорости

Из файлов **program_main.c** и **program_helpers.c** был сформирован код на ассемблере  (**program_main_speed.s** и **program_helpers_speed.s**) используя флаг оптимизации по скорости. Полученные файлы были ассемблированы и скомпонованы, получился файл **program_speed.out**.

### Оптимизация по размеру

Аналогично был сформирован код на ассемблере  (**program_main_size.s** и **program_helpers_size.s**) используя флаг оптимизации по размеру. Полученные файлы были ассемблированы и скомпонованы, получился файл **program_size.out**.

Сравнение полученных программ:

|                                         | program_modified |  program_speed  |  program_size  |
|-----------------------------------------|------------------|-----------------|----------------|
|        Размер ассемблерного кода        |       6429 B     |      4515 B     |      4030 B    |
|        Размер исполняемого файла        |      16384 B     |     16568 B     |     16552 B    |
|    Производительность (при вводе 1e6)   |      1.327 s     |       60 ns     |     0.978 s    |
