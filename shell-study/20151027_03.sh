#!/bin/bash
#test elif
if ./20151027_01.sh
then
	echo 20151027_01 word
elif ./20151027_02.sh
then
	echo 20151027_02 word
else
	echo all failed
fi
exit 0
