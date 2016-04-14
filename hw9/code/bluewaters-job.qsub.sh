#!/bin/bash
#PBS -N matvec
#PBS -q normal
#PBS -A babq
#PBS -j oe
#PBS -l walltime=00:05:00
#PBS -l nodes=64:ppn=32:xe
#PBS -m abe
#PBS -M jbradt@msu.edu

cd ${PBS_O_WORKDIR}

OUTFILE=output.tsv

PROCNUMS=(128 256 512 1024)
MATSIZES=(1024 16384 102400)

PROG_FLAGS="-e MPICH_NEMESIS_ASYNC_PROGRESS=1 -e MPICH_MAX_THREAD_SAFETY=multiple"

printf "matsize\tchunksize\tagtime\tringtime\n" > ${OUTFILE}

for NPROC in "${PROCNUMS[@]}"; do
    for M in "${MATSIZES[@]}"; do
        aprun -n $NPROC -N 16 ${PROG_FLAGS} ./matvec-mpi $M >> ${OUTFILE}
    done
done
