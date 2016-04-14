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

mpiexec -pernode comm_test

echo "Job statistics"
qstat -f $PBS_JOBID
