#!/bin/bash
#PBS -N mmul
#PBS -j oe
#PBS -o /mnt/home/jbradt/Documents/Code/extreme-scale/hw4/outputs/output.o
#PBS -l walltime=00:15:00
#PBS -l nodes=1:ppn=1
#PBS -l feature=intel14
#PBS -l mem=100mb
#PBS -m a
#PBS -M jbradt@msu.edu

cd /mnt/home/jbradt/Documents/Code/extreme-scale/hw4/code

for OLEVEL in ("0" "1" "2" "3")
do
    echo "Optimization level O$OLEVEL"

    for DIM in ("20" "100" "200" "800" "1000" "1200" "1600" "1800" "2000")
    do
        echo "For N=$DIM"

        ./mmul${OLEVEL} ${DIM}
    done
done
