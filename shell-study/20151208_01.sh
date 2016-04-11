#!/bin/bash
gawk 'BEGIN{FS=","}/11/{print $0}' log.20151207_1
echo ------------------------------------
gawk 'BEGIN{FS=","}$2~/^data2/{print $0}' log.20151207_1
echo ------------------------------------
gawk -F: '$1 ~ /db2/{print $1, $NF}' /etc/passwd
echo ------------------------------------
gawk -F: '$1 !~ /db2/{print $1, $NF}' /etc/passwd | tail -n 7
echo ------------------------------------
gawk -F: '$4 >= 500 {print $1, $NF}' /etc/passwd
