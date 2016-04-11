#!/bin/bash
# input change

echo change mointor input
exec 7<&0
exec 0<log.20151105_1

count=1
while read line
do
	echo $count"   "$line
	count=$[ $count + 1 ]
done

echo recover mointor input
exec 0<&7

if read -n1 -t 7 -p "Enter(Y|N)" result
then
	case $result in
		Y|y)
		echo
		echo "Yes";;
		N|n)
		echo
		echo "No";;
		*)
		echo
		echo "I don't know";;
	esac
fi
