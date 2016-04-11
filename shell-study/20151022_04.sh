#!/bin/bash
#this is a inline input redirection / bc command / back quotes usage test
number1=5.1
number2=4.2
number3=`bc<<EOF
scale=4
a=1*2*3*4
b=a/${number1}
b/${number2}
EOF
`
result=`echo "result is:${number3}"`
echo $result
