CC=clang

CFLAGS=-Wall -O3

EXEC=mmul
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)

# Main target
$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXEC)

%.o: %.cpp
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -f $(EXEC) $(OBJECTS)
