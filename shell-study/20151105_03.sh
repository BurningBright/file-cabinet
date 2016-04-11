#!/bin/bash
# input output read&write ending sign

exec 3>> log.20151105_1
echo this is an extra line to mark self define output >&3


echo change mointor output
exec 3>&1
exec 1>>log.20151105_1
echo this is an extra line to mark redefine sign output

exec 1>&3
echo recover mointor output



exec 3>>log.20151105_2
echo this is a line of data >&3

exec 3>&-
cat log.20151105_2

exec 3>>log.20151105_2
echo this wil be bad >&3
