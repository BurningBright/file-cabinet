#!/bin/bash
echo "7" | gawk '{printf "%d\n", exp($1)}'

echo -------------------------------------

echo "10000" | gawk '{printf "%d\n", sqrt($1)}'

echo -------------------------------------

echo "10000" | gawk '{printf "%d\n", log($1)}'

echo -------------------------------------

echo "2 3" | gawk '{printf "%d\n", and($1, $2)}'

echo -------------------------------------

echo "2 3" | gawk '{printf "%d\n", or($1, $2)}'

echo -------------------------------------

echo "2 3" | gawk '{printf "%d\n", xor($1, $2)}'

echo -------------------------------------

echo "2" | gawk '{printf "%d\n", compl($1)}'

echo -------------------------------------

echo "2 2" | gawk '{printf "%d\n", lshift($1, $2)}'

echo -------------------------------------

echo "8 2" | gawk '{printf "%d\n", rshift($1, $2)}'
