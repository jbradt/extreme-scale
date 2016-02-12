CC=icc

CFLAGS=-Wall -O0 -std=c11

EXEC=mmul
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)

# Main target
$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXEC)

.PHONY: clean
clean:
	rm -f $(EXEC) $(OBJECTS)
