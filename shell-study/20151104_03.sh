#!/bin/bash
#use special characte

# #@ is an array / #* is a variable

count=1
for var in $@
do
	echo the $count is $var
	count=$[ $count + 1 ]
done

count=1

# $1 variable's length will not be 0, "$1" as a string ,it's length will be 0
while [ -n "$1" ]
do
	echo the $count is $1
	count=$[ $count + 1 ]
	shift
done
