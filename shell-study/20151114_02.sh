#!/bin/bash
#test select command

. ./20151114_01.sh

select option in "Display disk space" "Display user info" "Display memory usage"
do
	case $option in
	"Display disk space")
		diskspace;;
	"Display user info")
		whoseon;;
	"Display memory usage")
		memusage;;
	*)
		clear;;
	esac
done
clear
