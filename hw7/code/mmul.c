#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Row-major indexing
#define ind(i,j) (i)*matSize+j

double mysecond();
void dummy(const double *);

void matrixMultiply(const double* matA, const double* matB, double* out, const size_t matSize)
{
    #pragma omp parallel for
    for (size_t i = 0; i < matSize; i++) {
        for (size_t j = 0; j < matSize; j++) {
            double sum = 0;
            for (size_t k = 0; k < matSize; k++) {
                sum += matA[ind(i,k)] * matB[ind(k,j)];
                dummy(matA);
            }
            out[ind(i,j)] = sum;
        }
    }
}

void fillMatrix(double* mat, const size_t matSize, const double value)
{
    for (size_t i = 0; i < matSize*matSize; i++) {
        mat[i] = value;
    }
}

int main(const int argc, const char** argv)
{
    size_t matSize = 1000;
    if (argc > 1) {
        matSize = atoi(argv[1]);
    }

    int numReps = 5;
    if (argc > 2) {
        numReps = atoi(argv[2]);
    }

    int innerLoopSize = 1;

    double* matA = malloc(matSize * matSize * sizeof(double));
    double* matB = malloc(matSize * matSize * sizeof(double));
    double* matC = malloc(matSize * matSize * sizeof(double));

    double minTime = 0;
    double maxTime = 0;
    double totTime = 0;

    for (int rep = -1; rep < numReps; rep++) {
        fillMatrix(matA, matSize, 1);
        fillMatrix(matB, matSize, 2);
        fillMatrix(matC, matSize, 0);

        double begin = mysecond();
        for (int innerIter = 0; innerIter < innerLoopSize; innerIter++) {
            matrixMultiply(matA, matB, matC, matSize);
        }
        double end = mysecond();

        double timeTaken = end - begin;

        if (rep < 0) {
            if (timeTaken < 1) {
                innerLoopSize = round(1 / timeTaken);
                printf("--Regular mult. took %0.4e s. Will iterate %d times.\n", timeTaken, innerLoopSize);
            }
        }

        if (rep >= 0) {
            timeTaken /= innerLoopSize;

            totTime += timeTaken;

            if (timeTaken > maxTime || rep == 0) maxTime = timeTaken;

            if (timeTaken < minTime || rep == 0) minTime = timeTaken;
        }

        dummy(matA);
        dummy(matB);
        dummy(matC);
    }

    printf("Seconds: %10.4e  %10.4e  %10.4e\n", minTime, totTime / numReps, maxTime);

    const double numOps = 2 * matSize * matSize * matSize;

    printf("FLOPS: %10.4e  %10.4e  %10.4e\n", numOps / minTime, numOps / (totTime / numReps), numOps / maxTime);

    free(matA);
    free(matB);
    free(matC);

    return 0;
}
