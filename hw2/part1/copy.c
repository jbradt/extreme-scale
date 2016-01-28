#include <stdlib.h>
#include <stdio.h>

#define N 5000000
#define NUM_ITERS 2000

void dummy (double* a, double* c);
double mysecond();

int main()
{
    double c[N], a[N];

    double start = mysecond();
    for (size_t iter = 0; iter < NUM_ITERS; iter++) {
        for (size_t i = 0; i < N; i++) {
            c[i] = a[i];
        }
        dummy(a, c);
    }
    double end = mysecond();
    double totTime = end - start;
    double meanTime = totTime / NUM_ITERS;

    printf("Array size = %d\n", N);
    printf("Num iters  = %d\n", NUM_ITERS);
    printf("Mean time  = %.2e s\n", meanTime);
    printf("Total time = %.2e s\n", totTime);
    printf("Rate       = %.2e MB/s\n", N * sizeof(double) * 2 / meanTime * 1e-6);

    return 0;
}
