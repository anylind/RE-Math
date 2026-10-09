# Math for Reverse Engineering

A small collection of mathematical tools and algorithms that support binary analysis, reverse engineering, and systems programming. The goal is to understand every algorithm, implement it, test its invariants, and then use it on real RE problems.

## Repository rules

Every tool should have:

1. A precise problem statement and supported input range.
2. The mathematical idea and algorithm, not just code.
3. A small example that can be checked by hand.
4. Automated tests, including an edge case.
5. A connection to a real RE, C, or low-level systems task.

Manual work is for understanding small examples. Programs are for reliable repetition and larger inputs. Outputs are verified, never trusted merely because the program printed them.

## First tool: modular inverse with EEA

`modinv` finds the multiplicative inverse of `a` modulo `m`, if it exists. It uses the Extended Euclidean Algorithm (EEA) to find integers `s` and `t` such that

```text
s*a + t*m = gcd(a, m)
```

An inverse exists exactly when `gcd(a, m) == 1`. In that case, reducing the identity modulo `m` gives

```text
s*a == 1 (mod m)
```

so `s mod m` is the inverse.

The program is deliberately scoped to values useful for 32-bit arithmetic: `0 <= a <= 2^32-1` and `2 <= m <= 2^32`. It accepts decimal input and `0x`-prefixed hexadecimal input. This is a learning tool, not a general-purpose cryptographic library.

## Build and test

```sh
make
make test
```

## Examples

```sh
./build/modinv 7 26
./build/modinv 11 37
./build/modinv 6 26
./build/modinv 0x045d9f3b 0x100000000
```

The last case reproduces the modular multiplier from RE-002. Its inverse should be `0x119de1f3` modulo `2^32`.

## Planned topics

- Extended Euclidean Algorithm and modular inverses
- Modular arithmetic and overflow in C
- XOR/shift reversible transformations
- Bit masks, shifts, and integer representation
- Small solvers for RE constraints
- Algorithmic complexity and search/pruning
