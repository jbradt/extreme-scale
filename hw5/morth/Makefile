ALL: all

LIBS   =
# To use this Makefile, either set the COMPILER_FAMILY on the command line
# to make or uncomment one of these lines
# COMPILER_FAMILY = gcc
#COMPILER_FAMILY = cray
#COMPILER_FAMILY = pgi
# COMPILER_FAMILY = intel
COMPILER_FAMILY = gcc

ifeq "$(COMPILER_FAMILY)" "gcc"
# GCC
#CC     = gcc-4.9.1
CC     = gcc-5.2
flags = -std=c99 -O3 -fivopts -flax-vector-conversions -funsafe-math-optimizations -msse4.2 -Wall -Werror
#-ftree-vectorize
#vecflags = -ftree-vectorizer-verbose=1
vecflags = -ftree-vectorizer-verbose=5
novecflags = -fno-tree-vectorize
noopt = -O0
endif

ifeq "$(COMPILER_FAMILY)" "clang"
# GCC
#CC     = gcc-4.9.1
CC     = clang-3.7.0
flags = -std=c99 -O3 -flax-vector-conversions -funsafe-math-optimizations -march=native -Wall -Werror
#-ftree-vectorize
#vecflags = -ftree-vectorizer-verbose=1
vecflags = -Rpass=loop-vectorize -Rpass-missed=loop-vectorize
novecflags = -fno-tree-vectorize
noopt = -O0
endif

ifeq "$(COMPILER_FAMILY)" "cray"
# craycc
CC = cc
flags      = -hc99 -O3  -hcpu=interlagos-cu -hreport=vf -hlist=m
vecflags   = -hvector3
novecflags = -hvector0
endif

ifeq "$(COMPILER_FAMILY)" "intel"
# icc
CC = icc
flags = -std=c99 -O3 -DHAVE_ICC
vecflags = -xHOST -qopt-report
novecflags = -no-vec
endif

ifeq "$(COMPILER_FAMILY)" "pgi"
# portland group
CC = pgcc
flag = -Mcache_align -Minfo -Mlist
vecflags = -O3 -fast -Mipa=fast,inline -Mlre -Mm128 -Mvect
novecflags = -O2 -Mnovect
endif

ifeq "$(COMPILER_FAMILY)" "generic"
CC = cc
flags = -O
vecflags =
novecflags =
endif

all : morth1

morth1: morth1.o morthr.o
	$(CC) morth1.o morthr.o -o morth1 $(LIBS)
morth1.o: morth1.c
	$(CC) $(flags) $(vecflags) -c morth1.c
morthr.o: morthr.c
	$(CC) $(flags) $(vecflags) -c morthr.c

clean :
	rm -f *.o morth1 *.lst

.PHONY: clean all
