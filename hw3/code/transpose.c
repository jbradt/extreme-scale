#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Row-major indexing
#define ind(i,j) (i)*N+j

double mysecond(void);

int checkTransposed(const double* A, const double* B, const size_t N)
{
    for (size_t i = 0; i < N; i++) {
        for (size_t j = 0; j < N; j++) {
            if (fabs(A[ind(i,j)] - B[ind(j,i)]) > 1e-4) return 0;
        }
    }
    return 1;
}

int main(const int argc, const char** argv)
{
    size_t N = 100;
    if (argc >= 2) {
        N = (size_t)atol(argv[1]);
    }

    printf("Naive transpose of %ld x %ld matrix\n", N, N);

    double* A = malloc(N*N*sizeof(double));
    double* B = malloc(N*N*sizeof(double));

    for (size_t i = 0; i < N*N; i++) {
        A[i] = i;
    }

    int numIters = 10;

    double meanTime = 0;
    double minTime = 0;
    double maxTime = 0;

    for (int iter = -1; iter < numIters; iter++) {
        double begin = mysecond();
        for (size_t i = 0; i < N; i++) {
            for (size_t j = 0; j < N; j++) {
                B[ind(j,i)] = A[ind(i,j)];
            }
        }
        double end = mysecond();
        double timeTaken = (end - begin);

        if (!checkTransposed(A, B, N)) puts("Transpose was not correct!");

        meanTime += timeTaken;
        if (iter == 0) {
            minTime = timeTaken;
            maxTime = timeTaken;
        }
        else if (iter > 0){
            if (timeTaken < minTime) minTime = timeTaken;
            if (timeTaken > maxTime) maxTime = timeTaken;
        }
    }

    meanTime /= numIters;

    printf("Best time:  %0.4e s\n", minTime);
    printf("Worst time: %0.4e s\n", maxTime);
    printf("Mean time:  %0.4e s\n", meanTime);

    free(A);
    free(B);
    return 0;
}
