#!/bin/bash
if [ -n "$line" ];then
         echo $line > files/select_proxy.txt
         awk '{print "select proxy_host_id from brandtology.Channel where id="$1""}' files/select_proxy.txt > files/select_proxy.sql
         proxy_id=`mysql -h 192.168.51.101 -ufly.chen -pg5nxrj?kN- -Bs < files/select_proxy.sql`

      if [ -n "$proxy_id" ];then
         while :
         do
            ramdom_host=`echo $(($RANDOM1+1))`
            if [ "$ramdom_host" -ne "24" -a "$proxy_id" -ne "$ramdom_host" ];then
               echo "$ramdom_host $line" > files/update_proxy.txt
               break
            else
               continue
            fi
         done
      fi

awk '{print "update brandtology.Channel set proxy_host_id="$1" where id="$2""}' files/update_proxy.txt > files/update_proxy.sql
mysql -h 192.168.51.101 -ufly.chen -pg5nxrj?kN- -Bs < files/update_proxy.sql
