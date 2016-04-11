#!/bin/bash
#loop list

var_1="l m n"
add="log.20151022"

IFS_TMP=$IFS
#$'\n:;"'	put new line / colon / semicolon / double quotes as separator
IFS=$'\n'


for test in a b c d\'e "f'g" "h i" j k $var_1 `cat $add`
do
	echo next is $test
done|sort -r

IFS=$IFS_TMP
