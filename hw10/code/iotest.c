#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdbool.h>

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

    int status;
    MPI_File fh;

    status = MPI_File_open(MPI_COMM_WORLD, filename, MPI_MODE_CREATE | MPI_MODE_WRONLY, MPI_INFO_NULL, &fh);
    if (status != MPI_SUCCESS) {
        rank_printf(0, "File open failed. Aborting.\n");
        MPI_Abort(MPI_COMM_WORLD, 3);
    }

    MPI_Offset zeroOffset = 0;
    MPI_File_set_view(fh, zeroOffset, MPI_DOUBLE, subarr_dtype, "native", MPI_INFO_NULL);

    MPI_File_write_all(fh, mat, subDims[0] * subDims[1], MPI_DOUBLE, MPI_STATUS_IGNORE);

    MPI_File_close(&fh);

    free(mat);

    MPI_Finalize();
}
