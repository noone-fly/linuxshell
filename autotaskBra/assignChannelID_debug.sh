#!/bin/bash
#author:fly
#build:2012-12-1
#modified:2013-6-14
#params:task number

rm NoDebugChannelID_temp 2>/dev/null
if [ $# -eq 0 ];then
   echo "The params are wrong, Try again please! (For example: assignChannelID.sh 12)"
   exit 0
fi

lines=`cat NoDebugChannelID | wc -l`

if [ "$lines" -ne "0" ];then
   LOOP=0
   while read line
   do
      if [ -n "$line" ];then

         echo $line > files/select_proxy.txt
         awk '{print "select proxy_host_id from BD.Channel where id="$1""}' files/select_proxy.txt > files/select_proxy.sql
         proxy_id=`mysql -h 192.168.51.101 -ufly.chen -pg5nxrj?kN- -Bs < files/select_proxy.sql`
      if [ -n "$proxy_id" ];then
         while :
         do
            ramdom_host=`echo $(($RANDOM1+1))`
#            awk '{print $1,$2}'  files/update_proxy.txt
            if [ "$ramdom_host" -ne "24" -a "$proxy_id" -ne "$ramdom_host" ]  ;then
               echo "$ramdom_host $line" > files/update_proxy.txt
               break
            else
               continue
            fi
         done
      fi

         awk '{print "update BD.Channel set proxy_host_id="$1" where id="$2""}' files/update_proxy.txt > files/update_proxy.sql
         mysql -h 192.168.51.101 -ufly.chen -pg5nxrj?kN- -Bs < files/update_proxy.sql
         echo $line >> NoDebugChannelID_temp
         LOOP=`expr $LOOP + 1`
         if [ "$LOOP" -ge "${1}" ];then
            break
         fi
      fi
   done < NoDebugChannelID
fi
sed -i "1,${LOOP}d" NoDebugChannelID

cat NoDebugChannelID_temp >> NoDebugChannelID
