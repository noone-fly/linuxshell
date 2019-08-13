#!/bin/sh
#listener_debug.sh
rm autodebug 2>/dev/null
touch autodebug

for PID in `ps -ef | grep 'DEBUG' | awk '{print $2}'`
do
   echo "pid : [$PID]" >> autodebug
done

process_num=`cat autodebug | wc -l`

if [ "$process_num" -gt "4" ];then
   rm autodebug 2>/dev/null
   ./killprocess.sh 2>>logs/killProcessByTimeLog
   exit 0
fi

if [ "$process_num" -lt "4" ];then
   case $process_num in

     
      3) echo "==3=="
          ./assignChannelID_debug.sh 1 2>>/dev/null 2>&1
          ./multipleTask.sh debug 1 2>>/dev/null 2>&1
        ;;
      2) echo "==2=="
          ./assignChannelID_debug.sh 2 2>>/dev/null 2>&1
          ./multipleTask.sh debug 2 2>>/dev/null 2>&1
        ;;
      1) echo "==1=="
          ./assignChannelID_debug.sh 3 2>>/dev/null 2>&1
          ./multipleTask.sh debug 3 2>>/dev/null 2>&1
        ;;
      0) echo "==0=="
         ./assignChannelID_debug.sh 4 2>>/dev/null 2>&1
         ./multipleTask.sh debug 4 2>>/dev/null 2>&1
        ;;
      *) echo "+++++++++++++++"
        exit 1
        ;;
   esac
fi