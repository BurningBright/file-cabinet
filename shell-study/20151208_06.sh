#!/bin/bash
gawk '$1 !~/^data51/{printf "%s,", $0}; $1 ~/^data51/{printf "%s", $0}' log.20151207_1 | 
gawk 'BEGIN{FS=","}{
	split($0, var)
	
	for( i in var ) {
		j = int(rand()*1000)
		tmp[j] = var[i]
		printf "%s	%s\n", i, var[i]
	}
	print "-------------------random"
	for( i in tmp ) {
		printf "%s	%s\n", i, tmp[i]
	}
	print "-------------------asort"
	asort(tmp, ret)
	for( i in ret ) {
		printf "%s	%s\n", i, ret[i]
	}
	print "-------------------asorti"
	asorti(tmp, ret)
	for( i in ret ) {
		printf "%s      %s\n", i, ret[i]
	}
}'
