#!/bin/bash
filelist=`ls ./csv/`
#for file in $(ls /home/pierre/Desktop/tool/testshell/csv/*.csv)
#for file in /home/pierre/Desktop/tool/testshell/csv/*.csv
#for file in for file in /home/pierre/Desktop/tool/testshell/csv/*.csv
for file in $filelist
do
   if [ -d "$file" ];then
       echo "$file is directory"
   elif [ -f "$file" ];then
       echo "$file is file"
   fi
done
