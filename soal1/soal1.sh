#!bin/bash

#1A 
allLogInfo=`grep -o "ticky:.*" syslog.log | cut -d " " -f 2-`

#1B
errorList=`echo "$allLogInfo" | grep -o "ERROR.*" | cut -d " " -f 2- | cut -d "(" -f 1 | sort -V | uniq -c | sort -nr`

#1C
userList=`echo "$allLogInfo" | cut -d "(" -f 2 | cut -d ")" -f 1 | sort | uniq`

#1D
echo "Error,Count" > error_message.csv
echo "$errorList" | while read cekerror
do
	namaerror=`echo $cekerror | cut -d ' ' -f 2-`
	jumlaherror=`echo $cekerror | cut -d ' ' -f 1`
	echo "$namaerror,$jumlaherror" 
done >> error_message.csv

#1E
echo "Username,Info,Error" > user_statistic.csv
echo "$userList" | 
while read user
    do
        thisInfoSum=$(grep -E "INFO.*($user))" syslog.log | wc -l)
        thisErrorSum=$(grep -E "ERROR.*($user))" syslog.log | wc -l)
        echo "$user,$thisInfoSum,$thisErrorSum"
    done >> user_statistic.csv;

