#!/bin/bash
#test shell function load

. ./20151113_02.lib

if `checkArgNum $*`
then
	echo TT
	addem $1 $2
	echo add result is $?

	multem $1 $2
	echo mult result is $?

	divem $1 $2
	echo div result is $?
else
	echo FF
fi


