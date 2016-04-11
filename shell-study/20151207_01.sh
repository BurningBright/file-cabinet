#!/bin/bash
gawk 'BEGIN{FS=","}{print $1 , $3 , $5 , $7}' log.20151207_1
echo --------------------------------
gawk 'BEGIN{FS=","; OFS="<->"}{print $1 , $3 , $5 , $7}' log.20151207_1
echo --------------------------------
gawk 'BEGIN{FIELDWIDTHS="4 2 1 4 2 1 4 2 1"; OFS="->"}{print $2 , $5 , $8}' log.20151207_1
echo --------------------------------
gawk 'BEGIN{FS="data"; RS="\n"}{print $1, $2, $3}' log.20151207_1
