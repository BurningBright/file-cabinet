#!/bin/bash
#test the command 'test' in float number
val=`echo "scale=7;1/3" | bc`
echo val is $val
if [$val -gt 1]
then
	echo result is greater than 1
else
	echo result is not greater than 1 or an exception occurred
fi
