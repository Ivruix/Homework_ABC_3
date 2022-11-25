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
