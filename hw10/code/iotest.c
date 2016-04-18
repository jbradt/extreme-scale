#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdbool.h>
#include <string.h>

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

char* strAddSuffix(const char* raw, const char* suffix)
{
    size_t newStrSize = strlen(raw) + strlen(suffix) + 1;
    char* newStr = malloc(newStrSize * sizeof(char));
    strcpy(newStr, raw);
    strcat(newStr, suffix);
    return newStr;
}

void writeCollective(MPI_Comm comm, const char* filename, MPI_Datatype dtype, const double *restrict data, size_t dataSize,
                     double *restrict times)
{
    int status;
    MPI_File fh;

    status = MPI_File_open(comm, filename, MPI_MODE_CREATE | MPI_MODE_WRONLY, MPI_INFO_NULL, &fh);
    if (status != MPI_SUCCESS) {
        rank_printf(0, "File open failed. Aborting.\n");
        MPI_Abort(MPI_COMM_WORLD, 3);
    }

    MPI_Offset zeroOffset = 0;
    MPI_File_set_view(fh, zeroOffset, MPI_DOUBLE, dtype, "native", MPI_INFO_NULL);

    double writeStart = MPI_Wtime();
    MPI_File_write_all(fh, data, dataSize, MPI_DOUBLE, MPI_STATUS_IGNORE);
    double writeEnd = MPI_Wtime();
    MPI_File_close(&fh);
    double fileClosed = MPI_Wtime();

    double localTimes[2] = {writeEnd - writeStart, fileClosed - writeEnd};

    MPI_Allreduce(&localTimes, times, 2, MPI_DOUBLE, MPI_MAX, comm);
}

void writeIndependent(MPI_Comm comm, const char* filename, const double *restrict data,
                      const int* fullDims, const int* subDims, const int* startLoc,
                      double *restrict times)
{
    int status;
    MPI_File fh;

    status = MPI_File_open(comm, filename, MPI_MODE_CREATE | MPI_MODE_WRONLY, MPI_INFO_NULL, &fh);
    if (status != MPI_SUCCESS) {
        rank_printf(0, "File open failed. Aborting.\n");
        MPI_Abort(MPI_COMM_WORLD, 3);
    }

    double writeStart = MPI_Wtime();
    for (int j = 0; j < subDims[1]; j++) {
        MPI_Offset offset = (startLoc[0] + (startLoc[1] + j) * fullDims[0]) * (MPI_Offset)sizeof(double);
        const double* colPtr = data + j * subDims[0];
        MPI_File_write_at(fh, offset, colPtr, subDims[0], MPI_DOUBLE, MPI_STATUS_IGNORE);
    }
    double writeEnd = MPI_Wtime();
    MPI_File_close(&fh);
    double fileClosed = MPI_Wtime();

    double localTimes[2] = {writeEnd - writeStart, fileClosed - writeEnd};

    MPI_Allreduce(&localTimes, times, 2, MPI_DOUBLE, MPI_MAX, comm);
}

int main(int argc, char** argv)
{
    int provided;
    MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE, &provided);

    int commRank = 0;
    int commSize = 0;
    MPI_Comm_rank(MPI_COMM_WORLD, &commRank);
    MPI_Comm_size(MPI_COMM_WORLD, &commSize);

    char* filename = "file.out";
    size_t nRows = 1024;
    size_t nCols = 1024;
    size_t stripingFactor = 0;

    if (argc > 1) {
        filename = argv[1];
    }
    else {
        rank_printf(0, "Must provide filename as first argument.\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }
    if (argc > 2) {
        nRows = atoi(argv[2]);
    }
    if (argc > 3) {
        nCols = atoi(argv[3]);
    }
    if (argc > 4) {
        stripingFactor = atoi(argv[4]);
    }

    int procDims[2];
    MPI_Dims_create(commSize, 2, procDims);

    int periodic[2] = {0, 0};
    MPI_Comm cartComm;
    MPI_Cart_create(MPI_COMM_WORLD, 2, procDims, periodic, false, &cartComm);

    int cartRank;
    int cartCoords[2];
    MPI_Comm_rank(cartComm, &cartRank);
    MPI_Cart_coords(cartComm, cartRank, 2, cartCoords);

    MPI_Datatype subarr_dtype;
    int fullDims[2] = {nRows, nCols};
    int subDims[2] = {nRows / procDims[0], nCols / procDims[1]};
    int startIdx[2] = {cartCoords[0] * subDims[0], cartCoords[1] * subDims[1]};
    MPI_Type_create_subarray(2, fullDims, subDims, startIdx, MPI_ORDER_FORTRAN, MPI_DOUBLE, &subarr_dtype);
    MPI_Type_commit(&subarr_dtype);

    double* mat = malloc(subDims[0] * subDims[1] * sizeof(double));
    if (mat == NULL) {
        MPI_Abort(MPI_COMM_WORLD, 2);
    }
    for (size_t i = 0; i < subDims[0]; i++) {
        for (size_t j = 0; j < subDims[1]; j++) {
            mat[i + j * subDims[0]] = (startIdx[0] + i) + (startIdx[1] + j) * nRows;
        }
    }

    char* suffixedFilename = strAddSuffix(filename, "-3");

    MPI_Barrier(cartComm);

    double collectiveTimes[2];
    writeCollective(cartComm, suffixedFilename, subarr_dtype, mat, subDims[0] * subDims[1], &collectiveTimes[0]);

    free(suffixedFilename);
    suffixedFilename = NULL;

    suffixedFilename = strAddSuffix(filename, "-0");

    MPI_Barrier(cartComm);

    double independentTimes[2];
    writeIndependent(cartComm, suffixedFilename, mat, fullDims, subDims, startIdx, &independentTimes[0]);

    rank_printf(0, "# % 5s\t% 5s\t% 3s\t% 5s\t% 6s\t% 9s\t% 9s\t% 9s\n", "m", "n", "k", "nproc", "method", "writeTime", "closeTime", "rate");
    rank_printf(0, "  % 5d\t% 5d\t% 3d\t% 5d\t% 6s\t%0.3e\t%0.3e\t%0.3e\n", nRows, nCols, stripingFactor, commSize, "coll",
                collectiveTimes[0], collectiveTimes[1], (double)nRows * (double)nCols * (double)sizeof(double) / collectiveTimes[0]);
    rank_printf(0, "  % 5d\t% 5d\t% 3d\t% 5d\t% 6s\t%0.3e\t%0.3e\t%0.3e\n", nRows, nCols, stripingFactor, commSize, "ind",
                independentTimes[0], independentTimes[1], (double)nRows * (double)nCols * (double)sizeof(double) / independentTimes[0]);

    free(suffixedFilename);

    free(mat);

    MPI_Finalize();
}
