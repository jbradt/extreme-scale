CC=clang

CFLAGS=-Wall -O0

trans: transpose.c mysecond.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -rf *.o trans
