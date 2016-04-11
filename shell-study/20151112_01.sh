#!/bin/bash
#about function and variables

function func1 {
	echo this is first function
}

function func2 {
	echo this is second function
	funcSecond=20000
}

function func3 {
	if [ $# -eq 2 ]
	then
		echo this is third function
		local tmp=$[ $1 + $2 ]
		result=$[ $1 * $2 ]
	fi
}

func1
echo first run is $?

func2
echo second run is $?
echo second result is $funcSecond


tmp=30000
value=30000
if [ $# -eq 2 ]
then
	`func3 $1 $2`
	func3 tmp value
	echo third result is $tmp $result
fi
