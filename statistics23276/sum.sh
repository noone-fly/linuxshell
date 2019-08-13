#!/bin/bash

touch text.csv
chmod 777 text.csv

audio_total=0
video_total=0
hostsd_total=0
hosthd_total=0
hosthdp_total=0
audiencesd_total=0
audiencehd_total=0
audiencehdp_total=0
file1=""

#filelist=`ls ./csv/`
#for file1 in $filelist
for file1 in $(ls /home/pierre/Desktop/tool/testshell/csv/*.csv)
do
   echo "================="
   echo -e $file1

   while read line
   do
      if [ -n "$line" ];then
         audio=`echo $line | awk -F ',' '{print $4}'`
         video=`echo $line | awk -F ',' '{print $5}'`
         host_SD=`echo $line | awk -F ',' '{print $6}'`
         host_HD=`echo $line | awk -F ',' '{print $7}'`
         host_HDP=`echo $line | awk -F ',' '{print $8}'`
         audience_SD=`echo $line | awk -F ',' '{print $9}'`
         audience_HD=`echo $line | awk -F ',' '{print $10}'`
         audience_HDP=`echo $line | awk -F ',' '{print $11}'`
         business=`echo $line | awk -F ',' '{print $14}'`
   
         if [ "$business" == "1" ];then

            let audio_total+=$audio
            let video_total+=$video
            let hostsd_total+=$host_SD
            let hosthd_total+=$host_HD
            let hosthdp_total+=$host_HDP
            let audiencesd_total+=$audience_SD
            let audiencehd_total+=$audience_HD
            let audiencehdp_total+=$audience_HDP
         fi
      fi
   done < $file1

   echo -e $file1,$audio_total,$video_total,$hostsd_total,$hosthd_total,$hosthdp_total,$audiencesd_total,$audiencehd_total,$audiencehdp_total
   echo -e $file1,$audio_total,$video_total,$hostsd_total,$hosthd_total,$hosthdp_total,$audiencesd_total,$audiencehd_total,$audiencehdp_total >> text.csv

audio_total=0
video_total=0
hostsd_total=0
hosthd_total=0
hosthdp_total=0
audiencesd_total=0
audiencehd_total=0
audiencehdp_total=0
done


