#!/bin/bash
#test menu manually

function diskspace {
	clear
	df -k
}

function whoseon {
	clear
	who
}

function memusage {
	clear
	cat /proc/meminfo
}

function menu {
	clear
	echo -e "\tSys Admin Menu\n"
	echo -e "\t1) Display disk space\n"
	echo -e "\t2) Display user info\n"
	echo -e "\t3) Display memory usage\n"
	echo -e "\t0) Exit\n"
	echo -en "\tEnter option"
	read -n1 option
}

while [ 1 ]
do
	menu
	case $option in
	1)
	diskspace;;
	2)
	whoseon;;
	3)
	memusage;;
	*)
	break;;
	esac
echo -en "\n\n\t Any key to continue"
read -n1 line
done
clear
