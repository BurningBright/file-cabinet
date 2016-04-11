#!/bin/bash
gawk 'BEGIN{print ARGC, ARGV[1]}' data1
echo ----------------------------------
gawk 'BEGIN{print ENVIRON["HOME"]; print ENVIRON["PATH"]}'
echo ----------------------------------
gawk 'BEGIN{FS=":"; OFS=":"}{print $1, $NR}' /etc/passwd | tail -n 7
echo ----------------------------------
gawk 'BEGIN{FS=","}{print $1, "NR="NR, "FNR="FNR}' log.20151207_1 log.20151207_1


echo ----------------------------------
gawk 'BEGIN{n="hello gawk"; print n}'
echo ----------------------------------
gawk 'BEGIN{FS=","}{print $n}' n=3 log.20151207_1
echo ----------------------------------
gawk -v n=5 -f 20151207_01.cmd log.20151207_1
