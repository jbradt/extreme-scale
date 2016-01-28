CC=clang

CFLAGS=-Wall -O2

stream: stream.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -rf *.o stream
