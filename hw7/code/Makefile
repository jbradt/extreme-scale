# CC=clang-3.7.0
# CFLAGS=-Wall -O0 -std=c11 -fopenmp=libomp

CC=icc
CFLAGS=-Wall -O3 -std=c11
OMPFLAGS=-qopenmp

SOURCES = $(wildcard *.c)

all: mmul-omp mmul-noomp

# Main target
mmul-noomp: $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) -o $@

mmul-omp: $(SOURCES)
	$(CC) $(CFLAGS) $(OMPFLAGS) $(SOURCES) -o $@

.PHONY: clean
clean:
	rm -f mmul-noomp mmul-omp
