#!/bin/bash
#testing multiple commands in the then section
user=oracle
if grep $user /etc/passwd
then
	echo The bash files for user $user are:
	ls -a /home/$user/.b*
else
	echo User not exist
fi
echo finish
exit 1
