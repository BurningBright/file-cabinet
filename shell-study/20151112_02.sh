#!/bin/bash
#about array use

newArr=(1 2 3 4 5)

function arrTest {
	local tmpArr=(`echo $@`)
	echo ${tmpArr[*]}

	local sum=0
	for value in ${tmpArr[*]}
	do
		sum=$[ $sum + $value ]
	done
	echo sum result is : $sum
}

function arrDeal {
	local oriArr=(`echo $@`)
	local newArr=(`echo $@`)
	local size=$#
	local i

	for (( i=0; i<$size; i++ ))
	do
		newArr[$i]=$[ ${oriArr[$i]} * 2 ]
	done
	echo ${newArr[*]}
}

arrTest ${newArr[*]}
arrDeal ${newArr[*]}
