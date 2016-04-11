#!/bin/dash

value1=10
value2=20
value3=$[ $value1 + $value2 ]
echo "result_1 is:" $value3

value3=$(( $value1 + $value2 ))
echo "result_2 is:" $value3

if [ $value1 == $value2 ]
then
	echo "xxxxxxxx\txxxxxxxx"

if [ $value1 = $value2]
then
	echo -e "xxxxxxxx\txxxxxx"
