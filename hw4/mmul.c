#include <stdlib.h>
#include <stdio.h>

// Row-major indexing
#define ind(i,j) (i)*matSize+j

/*
do	i=1,matSize
do	j=1,matSize
sum	=	0.0
do	k=1,matSize
!(Blocking	for	Part	2)
sum	=	sum	+	matA(i,k)*matB(k,j)
enddo
matC(i,j)	=	sum
enddo
enddo
*/

double mysecond();
void dummy(const double *);

int main(const int argc, const char** argv)
{
    size_t matSize = 1000;
    if (argc > 1) {
        matSize = atoi(argv[1]);
    }

    double* matA = malloc(matSize * matSize * sizeof(double));
    double* matB = malloc(matSize * matSize * sizeof(double));
    double* matC = malloc(matSize * matSize * sizeof(double));

    // Fill matrices
    for (size_t k = 0; k < matSize * matSize; k++) {
        matA[k] = 1;
        matB[k] = 2;
    }

    // Multiply
    double begin = mysecond();
    for (size_t i = 0; i < matSize; i++) {
        for (size_t j = 0; j < matSize; j++) {
            double sum = 0;
            for (size_t k = 0; k < matSize; k++) {
                sum += matA[ind(i,k)] * matB[ind(k,j)];
            }
            matC[ind(i,j)] = sum;
        }
    }
    double end = mysecond();

    dummy(matC);

    printf("Took %f\n", end-begin);

    free(matA);
    free(matB);
    free(matC);

    return 0;
}
