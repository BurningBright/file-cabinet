#!/bin/bash
#test if-then structure command
if date
then
	echo first work
	echo -n  list file
	ls -la ./
else
	echo first not work
fi

if aosifjpoa
then
	echo second work
else
	echo second not work
fi
echo "finish"
exit 1
