#!/bin/bash
echo "LinChenGuang" | gawk '{print tolower($1)}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print toupper($1)}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print substr($1, 4, 4); print substr($1, 4)}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print sub("Lin", "xxx", $1); print $1}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print split($1, var, /n/); for(i in var){ print var[i]}}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print match($1, /Guan/, var); for(i in var){ print var[i]}}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print length($1); print index($1, "Guan")}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print gsub(/n/, "|", $1); print $1}'

echo -------------------------------------------

echo "LinChenGuang" | gawk '{print gensub(/n/, "|", "G", $1)}'
echo "LinChenGuang" | gawk '{print gensub(/n/, "|", 2, $1)}'

echo -------------------------------------------

gawk 'BEGIN{date = systime(); print date
day = strftime("%Y %B %d %A", date); print day}'

echo -------------------------------------------

gawk 'BEGIN{print mktime("2015 12 08 18 35 12")}'
