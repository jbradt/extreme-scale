#!/bin/bash
#PBS -N comm_test
#PBS -q normal
#PBS -A babq
#PBS -j oe
#PBS -l walltime=00:05:00
#PBS -l nodes=32:ppn=32:xe
#PBS -m abe
#PBS -M jbradt@msu.edu

source ${HOME}/setenv_gcc.sh

cd ${PBS_O_WORKDIR}

aprun -n 32 -N 1 ./comm_test > output.out
