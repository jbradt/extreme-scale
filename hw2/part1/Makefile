CC=clang

CFLAGS=-Wall -O2

copy: copy.c dummy.c mysecond.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -rf *.o copy
