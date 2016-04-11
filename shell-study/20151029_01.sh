#!/bin/bash
#test command 'test' for string
var1=string
var2=String
if [$var1 \> $var2]
then
	echo "$var1 > $var2"
else
	echo "$var1 < $var2"
fi

echo `sort << EOF
string
String
EOF
`
