#!/bin/bash
#PBS -N matvec
#PBS -j oe
#PBS -l walltime=00:02:00
#PBS -l nodes=8:ppn=1
#PBS -l feature=intel14
#PBS -l mem=1gb
#PBS -m abe
#PBS -M jbradt@msu.edu

source ${HOME}/setenv_gcc.sh

cd ${PBS_O_WORKDIR}

OUTFILE=output.tsv

PROCNUMS=(128 256 512 1024)
MATSIZES=(1024 16384 102400)

printf "matsize\tchunksize\tagtime\tringtime\n" > ${OUTFILE}

for NPROC in "${PROCNUMS[@]}"; do
    for M in "${MATSIZES[@]}"; do
        mpiexec -n $NPROC ./matvec-mpi $M >> ${OUTFILE}
    done
done
