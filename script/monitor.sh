#!/bin/sh
#检测进程是否运行
#nohup ./monitor.sh >> monitor.log 2>&1 &
echo "Current directory is " $PWD
echo "Current process is " `pgrep -f monitor`
while : 
do 
isRunning=$(ps -ef | grep "app" | grep -v "grep")
if [ !"$isRunning" ] ; then
#    echo `date` "    app service was already started"
#else   
    echo `date` "    app service was not started"
    echo `date` "    Starting service ..."
fi
sleep 30s
done