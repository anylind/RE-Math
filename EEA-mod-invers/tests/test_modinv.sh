#!/bin/sh
set -eu

BIN=./build/modinv
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT HUP INT TERM

fail() {
    echo "FAIL: $*" >&2
    exit 1
}

check_contains() {
    output=$1
    expected=$2
    printf '%s\n' "$output" | grep -F -- "$expected" >/dev/null ||
        fail "expected output to contain: $expected"
}

out=$($BIN 7 26) || fail "case A exited unexpectedly"
check_contains "$out" "inverse   = 15"
check_contains "$out" "verify    = (a * inverse) mod modulus = 1"

echo "PASS: inverse of 7 modulo 26"

out=$($BIN 11 37) || fail "case B exited unexpectedly"
check_contains "$out" "inverse   = 27"
check_contains "$out" "verify    = (a * inverse) mod modulus = 1"

echo "PASS: inverse of 11 modulo 37"

out=$($BIN 15 26) || fail "case C exited unexpectedly"
check_contains "$out" "inverse   = 7"
check_contains "$out" "verify    = (a * inverse) mod modulus = 1"

echo "PASS: inverse of 15 modulo 26"

out=$($BIN 0x045d9f3b 0x100000000) || fail "RE-002 case exited unexpectedly"
check_contains "$out" "inverse_hex = 0x119de1f3"
check_contains "$out" "verify    = (a * inverse) mod modulus = 1"

echo "PASS: RE-002 32-bit multiplier inverse"

if $BIN 6 26 > "$tmp" 2>&1; then
    fail "6 modulo 26 should not have an inverse"
fi
noninvertible_output=$(cat "$tmp")
check_contains "$noninvertible_output" "gcd       = 2"
check_contains "$noninvertible_output" "inverse   = does not exist"

echo "PASS: detects non-invertible input"

if $BIN 12 1 >/dev/null 2>&1; then
    fail "modulus 1 should be rejected by this tool"
fi

echo "PASS: rejects invalid modulus"
echo "All tests passed."
