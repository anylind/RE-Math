CC ?= cc
CFLAGS ?= -std=c17 -O2 -Wall -Wextra -Wpedantic -Wconversion -Wshadow -Werror

.PHONY: all test clean

all: build/modinv

build/modinv: src/modinv.c
	@mkdir -p build
	$(CC) $(CFLAGS) $< -o $@

test: build/modinv
	sh tests/test_modinv.sh

clean:
	rm -rf build
