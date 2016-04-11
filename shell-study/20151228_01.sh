#!/bin/bash

CHECK_DIRECTORIES=" /home"
DATE=$(date '+%m%d%y')
exec > log.20151228_1
echo "Top ten disk space usage"
echo "For $CHECK_DIRECTORIES Directories"

for DIR_CHECK in $CHECK_DIRECTORIES
do
	echo ""
	echo "The $DIR_CHECK Directory:"
	du -Sh $DIR_CHECK 2>/dev/null | 
	sort -rn |
	sed '{11,$D; =}' |
	sed 'N; s/\n/ /' |
	gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
done
