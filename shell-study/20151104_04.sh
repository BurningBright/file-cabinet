#!/bin/bash
#deal the command options & getopt deal options

set -- `getopt -q ab:cd $@`

while [ -n "$1" ]
do
	#traditional method to read command options and arguments
	case "$1" in
		-a)
		echo found -a opt;;
		-b)
		echo -n found -b opt
		echo ", arg is $2"
		shift;;
		-c)
		echo found -c opt;;
		--)
		shift
		break;;
		*)
		$1 is not an opt;;
	esac
	shift
done

count=1
for var in $@
do
	echo $count argument is $var
	count=$[ $count + 1 ]
done
