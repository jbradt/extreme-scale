#include <stdlib.h>
#include <stdio.h>
#include <math.h>

// Row-major indexing
#define ind(i,j) (i)*matSize+j

#define MIN(a,b) ((a) < (b) ? a : b)

double mysecond();
void dummy(const double *);

void fillMatrix(double* mat, const size_t matSize, const double value)
{
    for (size_t i = 0; i < matSize*matSize; i++) {
        mat[i] = value;
    }
}

void matrixMultiply(const double* matA, const double* matB, double* out, const size_t matSize)
{
    for (size_t i = 0; i < matSize; i++) {
        for (size_t j = 0; j < matSize; j++) {
            double sum = 0;
            for (size_t k = 0; k < matSize; k++) {
                sum += matA[ind(i,k)] * matB[ind(k,j)];
            }
            out[ind(i,j)] = sum;
        }
    }
}

void blockedMatrixMultiply(const double* matA, const double* matB, double* out, const size_t matSize)
{
    const size_t bsize = 16;

    for (size_t i = 0; i < matSize; i += bsize) {
        for (size_t j = 0; j < matSize; j += bsize) {
            double sum = 0;
            for (size_t k = 0; k < matSize; k++) {
                for (size_t ii=i; ii < MIN(i+bsize,matSize); ii++) {
                    for (size_t jj=j; jj < MIN(j+bsize,matSize); jj++) {
                        sum += matA[ind(ii,k)] * matB[ind(k,jj)];
                    }
                }
            }
            out[ind(i,j)] = sum;
        }
    }
}

int matrixEqual(const double* matA, const double* matB, const size_t matSize)
{
    for (size_t i = 0; i < matSize; i++) {
        if (fabs(matA[i] - matB[i]) > 1e-4) {
            return 1;
        }
    }
    return 0;
}

int main(const int argc, const char** argv)
{
    size_t matSize = 1000;
    if (argc > 1) {
        matSize = atoi(argv[1]);
    }

    double* matA = malloc(matSize * matSize * sizeof(double));
    double* matB = malloc(matSize * matSize * sizeof(double));
    double* matC = malloc(matSize * matSize * sizeof(double));
    double* matD = malloc(matSize * matSize * sizeof(double));

    double minTime = 0;
    double maxTime = 0;
    double totTime = 0;
    double blockMinTime = 0;
    double blockMaxTime = 0;
    double blockTotTime = 0;

    const int numReps = 10;

    for (int rep = 0; rep < numReps; rep++) {
        fillMatrix(matA, matSize, 1);
        fillMatrix(matB, matSize, 2);
        fillMatrix(matC, matSize, 0);
        fillMatrix(matD, matSize, 0);

        double begin = mysecond();
        matrixMultiply(matA, matB, matC, matSize);
        double end = mysecond();

        double block_begin = mysecond();
        blockedMatrixMultiply(matA, matB, matD, matSize);
        double block_end = mysecond();

        double timeTaken = end - begin;
        double blockTimeTaken = block_end - block_begin;

        totTime += timeTaken;
        blockTotTime += timeTaken;

        if (timeTaken > maxTime || rep == 0) maxTime = timeTaken;
        if (blockTimeTaken > blockMaxTime || rep == 0) blockMaxTime = blockTimeTaken;

        if (timeTaken < minTime || rep == 0) minTime = timeTaken;
        if (blockTimeTaken < blockMinTime || rep == 0) blockMinTime = blockTimeTaken;

        if (!matrixEqual(matC, matD, matSize)) puts("Matrices were not equal!");

        dummy(matA);
        dummy(matB);
        dummy(matC);
        dummy(matD);
    }

    printf("\nResults: (all times are in seconds)\n\n");

    printf("            Max         Min         Mean   \n");
    printf("         ----------  ----------  ----------\n");
    printf("Regular: %10.4e  %10.4e  %10.4e\n", maxTime, minTime, totTime / numReps);
    printf("Blocked: %10.4e  %10.4e  %10.4e\n", blockMaxTime, blockMinTime, blockTotTime / numReps);

    free(matA);
    free(matB);
    free(matC);

    return 0;
}
