#!/bin/bash

MMULOMP=./mmul-omp
MMULNOOMP=./mmul-noomp

SIZES=("20" "100" "1000")
THREADS=("1" "2" "3" "4" "5" "6" "7" "8")

for SIZE in "${SIZES[@]}"; do
    echo "N=$SIZE TH=0"
    $MMULNOOMP $SIZE

    for THCT in "${THREADS[@]}"; do
        echo "N=$SIZE TH=$THCT"
        export OMP_NUM_THREADS=$THCT
        $MMULOMP $SIZE
    done
done
