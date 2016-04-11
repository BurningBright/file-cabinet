#!/bin/bash
gawk -F: '{
	if( $4 >= 500 ) {
		print "Yes", $1
	}else {
		print "No", $1
	}
}' /etc/passwd

echo ------------------------------

echo "" | gawk '{
	sum = 0 
	var = 100
	while( var > 0 ) {
		sum += var
		var--
	}
	print sum
}'

echo ------------------------------

echo "" | gawk '{
	sum = 0
	var = 100
	do{
		sum += var
		var--
	}while(var > 0)
	print sum
}'

echo ------------------------------

echo "" | gawk '{
	sum  = 0
	for(var = 100; var > 0; var--) {
		sum += var
	}
	print sum
}'
