#!/bin/sh
# move log 1 month ago

#echo 'hello backup';

date=`date -d '1 month ago' +'%Y-%m-%d'`
#echo $date;

default="/usr/xxx/logs/common-default.log."${date}".log"
error="/usr/xxx/logs/common-error.log."$date".log"
wx="/usr/xxx/logs/wx-logs.log."$date".log"

today=`date`
if [ -f "$default" ]; then
    echo $today' move '$default' to /data0/backup-log' >> /usr/xxx/logs/backup.log
    `mv $default /data0/backup-log`
fi

if [ -f "$error" ]; then
    echo $today' move '$error' to /data0/backup-log' >> /usr/xxx/logs/backup.log
    `mv $error /data0/backup-log`
fi

if [ -f "$wx" ]; then
    echo $today' move '$wx' to /data0/backup-log' >> /usr/xxx/logs/backup.log
    `mv $wx /data0/backup-log`
fi
