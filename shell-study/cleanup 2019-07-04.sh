#!/bin/sh
# delete log 6 month ago

echo 'hello cleanup';

date=`date -d '6 month ago' +'%Y-%m-%d'`
echo $date;

fList=find /data0/backup-log -type f -not -newermt $date
echo "$fList"

function my_function
{
    today=`date`
    while test $# -gt 0
    do
        `rm -f $1`
        echo '$today clean $1' >> /usr/xxx/logs/cleanup.log
        shift
    done
}

my_function $fList
