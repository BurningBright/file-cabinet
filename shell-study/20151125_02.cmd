BEGIN {
	print "it's begin"
	print "-------     -------"
	FS=":"
}
{
	print $1 "        " $7
}
END {
	print "-------     -------"
	print "it's end"
}
