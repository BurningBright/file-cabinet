#!/bin/bash
MYSQL=` which mysql`

TIME=`date +"%Y-%m-%d %H:%M:%S"`
SEQ=$RANDOM$RANDOM

$MYSQL tfb -u tfb -ptfb -e "INSERT INTO uls_order VALUES ('2150999999990035', '1', '$SEQ', '', 'dionysus', '701320593990001', '33010004', '100', '0', '0', '', '', '$TIME', '', null, '0', '0', '0')"
