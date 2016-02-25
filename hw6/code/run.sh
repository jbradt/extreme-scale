#!/bin/bash

NTS=("1" "2" "4" "6" "8" "10" "12" "14" "16")

for NT in "${NTS[@]}"
do
    echo "Num threads: $NT"
    export OMP_NUM_THREADS=$NT
    ./copy 50000000 20
done
