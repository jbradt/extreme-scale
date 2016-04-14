#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <stdarg.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>
#include <mpi.h>

void mvmult(const double *restrict mat, const double *restrict vec, const int matRows, const int matCols, const int matStride,
            const int vecRows, double *restrict result)
{
    assert(matCols == vecRows);
    for (int i = 0; i < matRows; i++) {
        double sum = result[i];
        for (int j = 0; j < matCols; j++) {
            sum += mat[j + matStride * i] * vec[j];
        }
        result[i] = sum;
    }
}

double multWithAllGather(const double *restrict mat, const double *restrict vec, double *restrict result,
                         const int matsize, const int chunkSize)
{
    double* fullVec = malloc(matsize * sizeof(double));

    double start = MPI_Wtime();
    MPI_Allgather(vec, chunkSize, MPI_DOUBLE, fullVec, chunkSize, MPI_DOUBLE, MPI_COMM_WORLD);
    mvmult(mat, fullVec, chunkSize, matsize, matsize, matsize, result);
    double end = MPI_Wtime();

    free(fullVec);

    return end - start;
}

double multWithRing(const double *restrict mat, const double *restrict vec, double *restrict result,
                    const int matsize, const int chunkSize)
{
    int rank;
    int commSize;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &commSize);

    int next = (rank == commSize - 1) ? 0 : rank + 1;
    int prev = (rank == 0) ? commSize - 1 : rank - 1;

    double* buffer = malloc(2 * chunkSize * sizeof(double));
    double *const buffer1 = buffer;
    double *const buffer2 = buffer + chunkSize;

    double* nextChunk = buffer1;
    const double* thisChunk = vec;

    double start = MPI_Wtime();
    for (int k = 0; k < commSize; k++) {
        MPI_Request reqs[2];
        MPI_Irecv(nextChunk, chunkSize, MPI_DOUBLE, next, 0, MPI_COMM_WORLD, &reqs[0]);
        MPI_Isend(thisChunk, chunkSize, MPI_DOUBLE, prev, 0, MPI_COMM_WORLD, &reqs[1]);

        int currentChunkNum = (rank + k) % commSize;
        const double* submat = mat + currentChunkNum * chunkSize;
        mvmult(submat, thisChunk, chunkSize, chunkSize, matsize, chunkSize, result);

        MPI_Waitall(2, reqs, MPI_STATUS_IGNORE);

        nextChunk = (nextChunk == buffer2) ? buffer1 : buffer2;
        thisChunk = (thisChunk == buffer1) ? buffer2 : buffer1;
    }
    double end = MPI_Wtime();

    free(buffer);

    return end - start;
}

void rank_printf(int rank, const char* fmt, ...)
{
    int myRank;
    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
    if (myRank == rank) {
        va_list args;
        va_start(args, fmt);
        vprintf(fmt, args);
        va_end(args);
    }
}

void printMatrix(const double *mat, const int nRows, const int nCols)
{
    for (int i = 0; i < nRows; i++) {
        for (int j = 0; j < nCols; j++) {
            printf("%0.1lf\t", mat[j + nCols*i]);
        }
        printf("\n");
    }
}

void initUnitMatrix(double *restrict mat, const int nRows, const int nCols, const int firstCol)
{
    memset(mat, 0, nRows * nCols * sizeof(double));
    for (int i = 0; i < nRows; i++) {
        int j = i + firstCol;
        mat[j + nCols * i] = 1;
    }
}

void initRangeVector(double *restrict vec, const int nRows, const double startVal)
{
    for (int i = 0; i < nRows; i++) {
        vec[i] = startVal + i;
    }
}

void initConstantVector(double *restrict vec, const int nRows, const double value)
{
    for (int i = 0; i < nRows; i++) {
        vec[i] = value;
    }
}

bool vecEqual(double *restrict vec1, double *restrict vec2, const int nRows) {
    for (int i = 0; i < nRows; i++) {
        if (fabs(vec1[i] - vec2[i]) > 1e-6) return false;
    }
    return true;
}

int main(int argc, char** argv)
{
    int provided = 0;
    MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &provided);

    int matsize = 128;
    if (argc > 1) {
        matsize = atoi(argv[1]);
    }

    const int numIters = 5;

    // rank_printf(0, "Full matrix size = %d\n", matsize);

    int commSize;
    MPI_Comm_size(MPI_COMM_WORLD, &commSize);

    int commRank;
    MPI_Comm_rank(MPI_COMM_WORLD, &commRank);

    int chunkSize = matsize / commSize;

    // rank_printf(0, "Each process takes %d rows\n", chunkSize);

    double* mat = malloc(chunkSize * matsize * sizeof(double));
    double* vec = malloc(chunkSize * sizeof(double));
    double* result = malloc(chunkSize * sizeof(double));

    double minAgTime = 1e9;
    for (int iter = 0; iter < numIters; iter++) {
        initUnitMatrix(mat, chunkSize, matsize, commRank * chunkSize);
        initRangeVector(vec, chunkSize, commRank * chunkSize);
        initConstantVector(result, chunkSize, 0);

        MPI_Barrier(MPI_COMM_WORLD);

        double agTime = multWithAllGather(mat, vec, result, matsize, chunkSize);
        if (!vecEqual(vec, result, chunkSize)) {
            printf("AG: Rank %d: Not equal!\n", commRank);
            for (int i = 0; i < chunkSize; i++) {
                printf("%lf\t%lf\t%e\n", vec[i], result[i], fabs(vec[i] - result[i]));
            }
        }

        double thisIterTime;
        MPI_Allreduce(&agTime, &thisIterTime, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD);
        if (thisIterTime < minAgTime) minAgTime = thisIterTime;
    }

    // rank_printf(0, "AG Time: %0.4e\n", minAgTime);

    double minRingTime = 1e9;
    for (int iter = 0; iter < numIters; iter++) {
        initUnitMatrix(mat, chunkSize, matsize, commRank * chunkSize);
        initRangeVector(vec, chunkSize, commRank * chunkSize);
        initConstantVector(result, chunkSize, 0);

        MPI_Barrier(MPI_COMM_WORLD);

        double ringTime = multWithRing(mat, vec, result, matsize, chunkSize);
        if (!vecEqual(vec, result, chunkSize)) {
            printf("Ring: Rank %d: Not equal!\n", commRank);
            for (int i = 0; i < chunkSize; i++) {
                printf("%lf\t%lf\t%e\n", vec[i], result[i], fabs(vec[i] - result[i]));
            }
        }

        double thisIterTime;
        MPI_Allreduce(&ringTime, &thisIterTime, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD);
        if (thisIterTime < minRingTime) minRingTime = thisIterTime;
    }

    // rank_printf(0, "Ring Time: %0.4e\n", minRingTime);

    rank_printf(0, "% 6d\t% 6d\t%0.4e\t%0.4e\n", matsize, chunkSize, minAgTime, minRingTime);

    free(mat);
    free(vec);
    free(result);

    MPI_Finalize();
}
