#!/bin/bash
MYSQL=` which mysql`

TIME=`date +"%Y-%m-%d %H:%M:%S"`
SEQ=$RANDOM$RANDOM

result=`$MYSQL tfb -u tfb -ptfb -e "select count(*) from uls_order t where t.card_number='2150999999990034' and t.is_covered in ('0','2')" | gawk 'BEGIN{FS="\n";RS=""}{print $2}'`

if [ $result = 0 ]
then
	$MYSQL tfb -u tfb -ptfb -e "INSERT INTO uls_order VALUES ('2150999999990034', '1', '$SEQ', '0', 'dionysus', '701320593990001', '33010003', '1', '0', '0', '', '', '$TIME', null, null, '0', '0', '0')"
	echo inserted
else
	echo record already there $result
fi

#$MYSQL tfb -u tfb -ptfb -e "INSERT INTO uls_order VALUES ('2150999999990034', '1', '$SEQ', '0', 'dionysus', '701320593990001', '33010003', '1', '0', '0', '', '', '$TIME', null, null, '0', '0', '0')"
