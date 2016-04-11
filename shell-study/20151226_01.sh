#!/bin/bash
MYSQL=` which mysql`

TIME="2015-12-20 05:05:05"

SQLS=""
for ((i=0; i<70; i++))
do
	#TIME=`date +"%Y-%m-%d %H:%M:%S"`
	SEQ=$RANDOM$RANDOM
	SQLS=${SQLS}"INSERT INTO uls_order VALUES ('2150999999999999', '1', '$SEQ', '0', 'dionysus', '701320593990001', '33010003', '1', '0', '0', '', '', '$TIME', null, null, '0', '2', '0');\n"
done

echo -e $SQLS | $MYSQL tfb -u tfb -ptfb
