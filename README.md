# Math for Reverse Engineering

A collection of small mathematical tools for reverse engineering and low-level systems work. Each tool is intended to make an algorithm understandable, testable, and useful when analyzing arithmetic in programs and binaries.

## Current tool

### Extended Euclidean Algorithm and modular inverse

[`EEA-mod-invers/`](EEA-mod-invers/) contains `modinv`, a C program that computes the multiplicative inverse of `a` modulo `m` when one exists. It uses the Extended Euclidean Algorithm to find Bézout coefficients and verifies the resulting inverse.

The tool accepts decimal and `0x`-prefixed hexadecimal integers. Its supported range is `0 <= a <= 2^32-1` and `2 <= m <= 2^32`. An inverse exists only when `gcd(a, m) == 1`.

## Build and run

From the tool directory:

```sh
cd EEA-mod-invers
make
./build/modinv 7 26
./build/modinv 0x045d9f3b 0x100000000
```

Run the test suite from the same directory with:

```sh
make test
```

The tests cover invertible and non-invertible inputs, invalid modulus values, and a 32-bit multiplier used in the RE-002 exercise. See [`EEA-mod-invers/README.md`](EEA-mod-invers/README.md) for the algorithm explanation, detailed examples, and limitations.

## Project direction

The repository is for studying arithmetic and solver techniques that appear in reverse engineering. Possible next topics include modular arithmetic and overflow, reversible XOR/shift transformations, bit operations, and constraint solving. These are areas for future work; the modular-inverse tool is the current implementation.

## License

This project is distributed under the Mozilla Public License 2.0. See [`LICENSE`](LICENSE).

 ***⭐***
