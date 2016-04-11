#!/bin/bash
#test $0 $1 $2

if [ -n $1 ] && [ -n $2 ]
then
	echo welcome calculation
else
	echo parameter lost
fi

comm=`basename $0`
echo -n $comm
echo " "$1" "$2

if [ $comm == "20151104_01.sh" ]
then
	echo $1 \+ $2 = $[ $1+$2 ]
elif [ $comm == "20151104_02.sh" ]
then
	echo $1 \* $2 = $[ $1*$2 ]
fi
