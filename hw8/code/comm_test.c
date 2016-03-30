#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>


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

void pingpong_blocking(int i, int j, int m, int rank)
{
    // printf("In func, my rank is %d, i=%d, j=%d\n", rank, i, j);
    if (rank == i) {
        char* data = malloc(m * sizeof(char));
        MPI_Send(data, m, MPI_CHAR, j, 0, MPI_COMM_WORLD);
        MPI_Recv(data, m, MPI_CHAR, j, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        // printf("Sent from process %d\n", i);
        free(data);
    }
    if (rank == j) {
        char* data = malloc(m * sizeof(char));
        MPI_Recv(data, m, MPI_CHAR, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Send(data, m, MPI_CHAR, i, 0, MPI_COMM_WORLD);
        // printf("Received in process %d\n", j);
        free(data);
    }
}

void pingpong_nonblocking(int i, int j, int m, int rank)
{
    // printf("In func, my rank is %d, i=%d, j=%d\n", rank, i, j);
    if (rank == i) {
        char* data = malloc(m * sizeof(char));
        MPI_Request req;
        MPI_Isend(data, m, MPI_CHAR, j, 0, MPI_COMM_WORLD, &req);
        MPI_Wait(&req, MPI_STATUS_IGNORE);

        MPI_Irecv(data, m, MPI_CHAR, j, 0, MPI_COMM_WORLD, &req);
        MPI_Wait(&req, MPI_STATUS_IGNORE);
        // printf("Sent from process %d\n", i);
        free(data);
    }
    if (rank == j) {
        char* data = malloc(m * sizeof(char));
        MPI_Request req;
        MPI_Irecv(data, m, MPI_CHAR, i, 0, MPI_COMM_WORLD, &req);
        MPI_Wait(&req, MPI_STATUS_IGNORE);

        MPI_Isend(data, m, MPI_CHAR, i, 0, MPI_COMM_WORLD, &req);
        MPI_Wait(&req, MPI_STATUS_IGNORE);
        // printf("Received in process %d\n", j);
        free(data);
    }
}

void head_to_head(int i, int j, int m, int rank)
{
    if ((rank != i) && (rank != j)) return;

    int other = (rank == i ? j : i);

    char* msg_out = malloc(m * sizeof(char));
    char* msg_in = malloc(m * sizeof(char));

    MPI_Request req[2];
    MPI_Isend(msg_out, m, MPI_CHAR, other, 0, MPI_COMM_WORLD, &req[0]);
    MPI_Irecv(msg_in, m, MPI_CHAR, other, 0, MPI_COMM_WORLD, &req[1]);
    MPI_Waitall(2, req, MPI_STATUS_IGNORE);
}

int main(int argc, char** argv)
{
    int provided;
    MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE, &provided);

    int size, rank;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    rank_printf(0, "Running with %d MPI processes\n", size);

    if (rank == 0) {
        double tickSize = MPI_Wtick();
        printf("MPI wall clock resolution: %0.4le seconds\n", tickSize);
    }

    double start, end;

    if (rank == 0 || rank == 1) {
        start = MPI_Wtime();
        pingpong_blocking(0, 1, 204813, rank);
        end = MPI_Wtime();
        rank_printf(0, "Took %0.4le seconds\n", end-start);
    }

    MPI_Barrier(MPI_COMM_WORLD);  // ----------------------------------------------------------------------

    if (rank == 0 || rank == 1) {
        start = MPI_Wtime();
        pingpong_nonblocking(0, 1, 204813, rank);
        end = MPI_Wtime();
        rank_printf(0, "Took %0.4le seconds\n", end-start);
    }

    MPI_Barrier(MPI_COMM_WORLD);  // ----------------------------------------------------------------------

    if (rank == 0 || rank == 1) {
        start = MPI_Wtime();
        head_to_head(0, 1, 204813, rank);
        end = MPI_Wtime();
        rank_printf(0, "Took %0.4le seconds\n", end-start);
    }

    MPI_Finalize();
    return 0;
}
