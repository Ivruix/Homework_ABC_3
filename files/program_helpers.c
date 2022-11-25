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
