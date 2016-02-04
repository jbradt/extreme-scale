CC=clang

CFLAGS=-Wall -O0

all: trans blocktrans cotrans
.PHONY: all

trans: transpose.c mysecond.c
	$(CC) $(CFLAGS) -o $@ $^

blocktrans: block_transpose.c mysecond.c
	$(CC) $(CFLAGS) -o $@ $^

cotrans: cotranspose.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -rf *.o trans blocktrans cotrans
