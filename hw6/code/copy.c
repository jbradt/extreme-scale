#include <stdlib.h>
#include <stdio.h>

void dummy (double* a, double* c);
double mysecond();

int main(const int argc, const char** argv)
{
    size_t N = 1000;
    size_t numIters = 2000;

    if (argc > 1) {
        N = atoi(argv[1]);
    }
    if (argc > 2) {
        numIters = atoi(argv[2]);
    }

    double* c = calloc(N, sizeof(double));
    double* a = calloc(N, sizeof(double));

    double start = mysecond();
    for (size_t iter = 0; iter < numIters; iter++) {
        #pragma omp parallel for default(none) shared(c, a, N) schedule(static)
        for (size_t i = 0; i < N; i++) {
            c[i] = a[i];
        }
        dummy(a, c);
    }
    double end = mysecond();
    double totTime = end - start;
    double meanTime = totTime / numIters;

    printf("Array size = %lu\n", N);
    printf("Num iters  = %lu\n", numIters);
    printf("Mean time  = %.2e s\n", meanTime);
    printf("Total time = %.2e s\n", totTime);
    printf("Rate       = %.2e MB/s\n", N * sizeof(double) * 2 / meanTime * 1e-6);

    free(a);
    free(c);

    return 0;
}
