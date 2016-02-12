#!/bin/bash
#PBS -N mmul
#PBS -j oe
#PBS -o /mnt/home/jbradt/Documents/Code/extreme-scale/hw4/outputs/output.o
#PBS -l walltime=01:00:00
#PBS -l nodes=1:ppn=1
#PBS -l feature=intel14
#PBS -l mem=250mb
#PBS -m a
#PBS -M jbradt@msu.edu
#PBS -t 0,1,2,3

cd /mnt/home/jbradt/Documents/Code/extreme-scale/hw4/code

DIMS=("20" "100" "200" "800" "1000" "1200" "1600" "1800" "2000")

echo "Optimization level O${PBS_ARRAYID}"

for DIM in "${DIMS[@]}"
do
    echo "For N=$DIM"

    ./mmul${PBS_ARRAYID} ${DIM}
done
