#!/bin/bash

listfile=""
date=""
sourcefile="/home/pierre/Desktop/tool/testshell/csv/*.csv"
targetfile="223039_1.csv"

touch $targetfile
chmod 777 $targetfile
echo -e Date,AudioTotal,VideoTotal,HostSDTotal,HostHDTotal,HostHDPTotal,AudienceSDTotal,AudienceHDTotal,AudienceHDPTotal >> $targetfile

for file in $(ls $sourcefile)
do
   if [ -f "$file" ];then
      echo "================= $file ================"
      audio_total=`awk -F ',' '$14 ~ /1/{sum += $4};END {print sum}' $file`
      video_total=`awk -F ',' '$14 ~ /1/{sum += $5};END {print sum}' $file`
      hsd_total=`awk -F ',' '$14 ~ /1/{sum += $6};END {print sum}' $file`
      hhd_total=`awk -F ',' '$14 ~ /1/{sum += $7};END {print sum}' $file`
      hhdp_total=`awk -F ',' '$14 ~ /1/{sum += $8};END {print sum}' $file`
      asd_total=`awk -F ',' '$14 ~ /1/{sum += $9};END {print sum}' $file`
      ahd_total=`awk -F ',' '$14 ~ /1/{sum += $10};END {print sum}' $file`
      ahdp_total=`awk -F ',' '$14 ~ /1/{sum += $11};END {print sum}' $file`

      date=`echo $file | awk -F '/' '{print $8}' | sed 's/.csv//g'`
      echo -e $date,$audio_total,$video_total,$hsd_total,$hhd_total,$hhdp_total,$asd_total,$ahd_total,$ahdp_total
      echo -e $date,$audio_total,$video_total,$hsd_total,$hhd_total,$hhdp_total,$asd_total,$ahd_total,$ahdp_total >> $targetfile

      audio_total=0
      video_total=0
      hsd_total=0
      hhd_total=0
      hhdp_total=0
      asd_total=0
      ahd_total=0
      ahdp_total=0
   else
      echo -e "Please confirm the varible of sourcefile is correct!"
   fi
done


