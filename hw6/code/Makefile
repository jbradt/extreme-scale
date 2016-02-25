CC=clang-3.7.0

CFLAGS=-Wall -O0 -std=c11 -fopenmp=libomp

EXEC=copy
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)

# Main target
$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(EXEC)

.PHONY: clean
clean:
	rm -f $(EXEC) $(OBJECTS)
