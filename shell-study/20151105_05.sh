#!/bin/bash
# use tmp file mktemp

curr=`pwd`
dir=`mktemp -d -t lcg.XXXXXX`
cd $dir
tmpfile1=`mktemp file.XXX`
tmpfile2=`mktemp file.XXX`

exec 5> $tmpfile1
exec 6> $tmpfile2

echo tmp first >&5
echo tmp second >&6

cat $tmpfile1
cat $tmpfile2

if rm -rf $dir
then
	cd $curr
	echo done | tee -a log.20151105_2
else
	echo error
fi
