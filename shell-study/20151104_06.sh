#!/bin/bash
#user input `read command`

read -p "What's you name ?"
echo Hello $REPLY

if read -t 7 -n1 -p "Are you ready ?(Y|N)"
then
	case $REPLY in
	Y|y)
		echo
		echo "Welcome halo world ---";;
	N|n)
		echo
		echo "Bye ---";;
	*)
		echo
		echo "I don't know what you mean ---";;
	esac
else
	echo "quit"
fi

if read -t 7 -s -p "Enter password :"
then
	if [ $REPLY == "123456" ]
	then
		count=1
		cat "log.20151022" | while read line
		do
			echo $count"   "$line
			count=$[ $count + 1 ]
		done
		echo "data loaded"
	else
		echo "Password error"
	fi
else
	echo "quit"
fi
