#include <stdio.h>
#include <sys/types.h>
#include <sys/time.h>
#include <stdlib.h>

/*
 * Example of sparse matrix-vector multiply, using CSR (compressed sparse
 * row format).  Because this code is in C, the index values in the ia and ja
 * arrays are zero origin rather than one origin as they would be in Fortran.
 *
 * While this code does time the sparse matrix-vector product, as noted below,
 * these timings are too simple to be used for serious analysis.
 */
int main(int argc, char *argv[])
{
    int    *ia, *ja;
    double *a, *x, *y;
    int    row, i, j, idx, n, nnzMax, nnz, nrows;
    struct timeval  tStart, tEnd;
    double t, rate;

    n = 10;
    if (argc > 1) n = atoi(argv[1]);

    /* Warning: if n > sqrt(2^31), you may get integer overflow */

    /* Allocate enough storage for the matix.  We allocate more than
       is needed in order to simplify the code */
    nrows  = n * n;
    nnzMax = nrows * 5;
    ia = (int*)malloc(nrows*sizeof(int));
    ja = (int*)malloc(nnzMax*sizeof(int));
    a  = (double*)malloc(nnzMax*sizeof(double));
    /* Allocate the source and result vectors */
    x = (double*)malloc(nrows*sizeof(double));
     y = (double*)malloc(nrows*sizeof(double));

    /* Create a pentadiagonal matrix, representing very roughly a finite
       difference approximation to the Laplacian on a square n x n mesh */
    row = 0;
    nnz = 0;
    for (i=0; i<n; i++) {
	for (j=0; j<n; j++) {
	    ia[row] = nnz;
	    if (i>0) { ja[nnz] = row - n; a[nnz] = -1.0; nnz++; }
	    if (j>0) { ja[nnz] = row - 1; a[nnz] = -1.0; nnz++; }
	    ja[nnz] = row; a[nnz] = 4.0; nnz++;
	    if (j<n-1) { ja[nnz] = row + 1; a[nnz] = -1.0; nnz++; }
	    if (i<n-1) { ja[nnz] = row + n; a[nnz] = -1.0; nnz++; }
	    row++;
	}
    }
    ia[row] = nnz;

    /* Create the source (x) vector */
    for (i=0; i<nrows; i++) x[i] = 1.0;

    /* Perform a matrix-vector multiply: y = A*x */
    /* Warning: To use this for timing, you need to (a) handle cold start
       (b) perform enough tests to make timing quantum relatively small */
    gettimeofday( &tStart, 0 );
    for (row=0; row<nrows; row++) {
	double sum = 0.0;
	for (idx=ia[row]; idx<ia[row+1]; idx++) {
	    sum += a[idx] * x[ja[idx]];
	}
	y[row] = sum;
    }
    gettimeofday( &tEnd, 0 );
    t = (tEnd.tv_sec - tStart.tv_sec) +
	1.0e-6 * (tEnd.tv_usec - tStart.tv_usec);
    /* Compute with the result to keep the compiler for marking the
       code as dead */
    for (row=0; row<nrows; row++) {
	if (y[row] < 0) {
	    fprintf(stderr,"y[%d]=%f, fails consistency test\n", row, y[row]);
	}
    }
    printf("Time for Sparse Ax, nrows=%d, nnz=%d, T = %f\n", nrows, nnz, t);

    free(ia); free(ja); free(a); free(x); free(y);
    return 0;
}
