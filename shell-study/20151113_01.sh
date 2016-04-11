#!/bin/bash
#about recursion

function recur {
	if [ $1 -eq 1 ]
	then
		echo 1
	else
		local tmp=$[ $1 - 1 ]
		tmp=`recur $tmp`
		echo $[ $1 * $tmp ]
	fi
}

recur 5
