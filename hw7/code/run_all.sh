#!/bin/bash
#PBS -N mmul-omp
#PBS -j oe
#PBS -o /mnt/home/jbradt/Documents/Code/extreme-scale/hw7/outputs/output.o
#PBS -l walltime=01:30:00
#PBS -l nodes=1:ppn=20
#PBS -l feature=intel14
#PBS -l mem=500mb
#PBS -m abe
#PBS -M jbradt@msu.edu

cd ${HOME}/Documents/Code/extreme-scale/hw7/code

MMULOMP=./mmul-omp
MMULNOOMP=./mmul-noomp

SIZES=("20" "100" "200" "800" "1000" "1200" "1600" "1800" "2000")

for SIZE in "${SIZES[@]}"; do
    echo "N=$SIZE TH=0"
    $MMULNOOMP $SIZE

    for THCT in {1..20}; do
        echo "N=$SIZE TH=$THCT"
        export OMP_NUM_THREADS=$THCT
        $MMULOMP $SIZE
    done
done
