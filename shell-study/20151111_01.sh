#!/bin/bash
# catch sign

trap "echo 'i have trapped ctrl + c'" SIgINT SIGTERM
trap "echo 'done bye bye'" EXIT

count=1
while [ $count -le 20 ]
do
	if [ $count -eq 6 ]
	then
		trap - SIGINT SIGTERM
		echo 'SIGINT SIGTERM has been remove'
	fi
	echo loop $count
	sleep 3
	count=$[ $count + 1 ]
done
