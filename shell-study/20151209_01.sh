#!/bin/bash
echo "fist second third" | gawk '
function printSec() {
	print $2
}
{
	printSec()
}'

echo "fist second third" | gawk -f 20151209_01.lib  -f 20151209_02.lib
