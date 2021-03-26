#!bin/bash

#1A 
error="$(grep -E -o "ERROR" syslog.log)"
info="$(grep -E -o "INFO" syslog.log)"
errorCount="$(grep -o "ERROR" syslog.log | wc -l)"
infoCount="$(grep -o "INFO" syslog.log | wc -l)"

#1B
errorList=`grep -o 'ERROR.*' syslog.log | cut -d" " -f2- | cut -d "(" -f1 | sort -V | uniq -c | sort -nr`

#1C
userList=`cut -d"(" -f2 < syslog.log | cut -d ")" -f1 | sort | uniq`

#1D
echo "Error,Count" > error_message.csv
printf "$errorList" | while read cekerror
do
	namaerror=`echo $cekerror | cut -d' ' -f2-`
	jumlaherror=`echo $cekerror | cut -d' ' -f1`
	echo "$namaerror,$jumlaherror" 
done >> error_message.csv

#1E
echo "Username,Info,Error" > user_statistic.csv
printf "$userList" | 
while read user
    do
        thisInfoSum=$(grep -E "INFO.*($user))" syslog.log | wc -l)
        thisErrorSum=$(grep -E "ERROR.*($user))" syslog.log | wc -l)
        echo "$user,$thisInfoSum,$thisErrorSum"
    done >> user_statistic.csv;

