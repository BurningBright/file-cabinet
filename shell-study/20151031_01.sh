#!/bin/bash
#if-then's advance feature

if ((2**2>2))
then
	echo double parentheses worked
else
	echo double parentheses failed
fi

if [[ $USER == r* ]]
then
	echo $USER
else
	echo double bracket failed
fi

var=123456
case $var in
123456)
	echo $var
	var=654321;;
654321)
	echo $var;;
*)
	echo default out put;;
esac
