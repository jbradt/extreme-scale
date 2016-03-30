#!/bin/bash
#PBS -N comm_test
#PBS -j oe
#PBS -l walltime=00:02:00
#PBS -l nodes=4:ppn=1
#PBS -l feature=intel14
#PBS -l mem=500mb
#PBS -m abe
#PBS -M jbradt@msu.edu

source ${HOME}/setenv_gcc.sh

mpiexec comm_test
