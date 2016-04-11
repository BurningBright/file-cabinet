#!/bin/bash
gawk 'BEGIN{
	var["a"] = 1
        var["r"] = 2
        var["g"] = 3
        var["s"] = 4
	for(test in var) {
		print "Index:", test, " - value is ", var[test]
	}
	print "---------------------------"
	delete var["s"]
	for(test in var) {
                print "Index:", test, " - value is ", var[test]
        }
}'
