#!/bin/bash
#redirect read file

exec 0< log.20151105_1

count=1
while read line
do
	echo $count"   "$line
	count=$[ $count + 1 ]
done
