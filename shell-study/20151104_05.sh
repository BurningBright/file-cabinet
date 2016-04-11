#!/bin/bash
#use advantage getopts command to deal option

while getopts :ab:cd opt
do
	case $opt in
		a)
		echo found command -a;;
		b)
		echo -n found command -b
		echo ", arg is $OPTARG";;
		c)
		echo found command -c;;
		*)
		echo unknow command $opt;;
	esac
done
#move to the front of current opint
shift $[ $OPTIND-1 ]


count=1
for var in $@
do
	echo $count argument is $var
	count=$[ $count+1 ]
done
