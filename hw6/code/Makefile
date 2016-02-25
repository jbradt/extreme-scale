CC=clang-3.7.0

CFLAGS=-Wall -O0 -std=c11 -fopenmp=libiomp5 -L/Users/josh/miniconda3/envs/analysis/lib -liomp5

EXEC=copy
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)

# Main target
$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXEC)

.PHONY: clean
clean:
	rm -f $(EXEC) $(OBJECTS)
