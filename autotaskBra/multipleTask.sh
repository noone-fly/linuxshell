#!/bin/bash
#author:Fly 2012/09/10
#modified:Fly 2013/6/14
#multiple task execution (feeder.sh,crawler.sh,debug.sh, monitor.sh)
#param:debug,feeder,crawler

if [ $# -eq 0 ];then
   echo "please make sure the params is (debug/feeder/crawler/monitor), thank you!"
   exit 0
fi

#send_thread_num=20

if [ ${1} = "debug" ];then
   send_thread_num=11

elif [ ${1} = "feeder" ];then
   send_thread_num=11

elif [ ${1} = "crawler" ];then
   send_thread_num=11
  
elif [ ${1} = "monitor" ];then
   send_thread_num=11
fi

tmp_fifofile="/tmp/$$.filo"
mkfifo "$tmp_fifofile"
exec 6<>"$tmp_fifofile"
rm $tmp_fifofile

for ((i=0;i<$send_thread_num;i++));do
   echo
done >&6

if [ ${1} = "debug" ];then
   num=`sed -n '$=' NoDebugChannelID_temp`
elif [ ${1} = "feeder" ];then
   num=`sed -n '$=' NoFeedChannelID_temp`
elif [ ${1} = "crawler" ];then
   num=`sed -n '$=' NoCrawlChannelID_temp`
elif [ ${1} = "monitor" ];then
   num=`sed -n '$=' NomonitorChannelID_temp`
fi

for i in `seq 1 $num`;do
   read -u6
   {
      #m=`sed -n "${i}p" channellist`
      if [ ${1} = "debug" ];then
         m=`sed -n "${i}p" NoDebugChannelID_temp`
      elif [ ${1} = 'feeder' ];then
         m=`sed -n "${i}p" NoFeedChannelID_temp`
      elif [ ${1} = 'crawler' ];then
         m=`sed -n "${i}p" NoCrawlChannelID_temp`
      elif [ ${1} = 'monitor' ];then
         m=`sed -n "${i}p" NomonitorChannelID_temp`
      fi

      if [ -n "$m" ];then
         cd /BD/crawler/v2script/
         if [ $# -ne 0 ];then
            if [ ${1} = "debug" ];then
               /BD/crawler/v2script/debug.sh $m
            elif [ ${1} = 'feeder' ];then
               /BD/crawler/v2script/feeder.sh $m
            elif [ ${1} = 'crawler' ];then
               /BD/crawler/v2script/crawler.sh $m
            elif [ ${1} = 'monitor' ];then
               /BD/crawler/v2script/monitor.sh $m
            else
               echo "please make sure the param is (debug/feeder/crawler/monitor)! thank you"
            fi
         fi
      fi
      sleep 3
      echo >&6
   }&
   pid=$!
   #echo $pid
done

wait
exec 6>&-
exit 0