#!/bin/sh
#author:fly
#build:2012-10-20

mysql -h 192.168.51.101 -ufly.chen -pg5nxrj?kN- -e "SELECT ch.ID FROM BD.Channel ch LEFT JOIN ( SELECT DISTINCT(s.Channel_ID) ID FROM BD.Subscribed_Channel s,BD.Client_Account c WHERE c.ID=s.Client_Account_ID AND c.Is_Active = 1) AS tmp ON ch.ID=tmp.ID WHERE ch.Location_Feeder IS NOT NULL AND ch.To_Monitor=1 AND tmp.ID IS NOT NULL and ch.url like '�cebook%' ORDER BY ch.ID;" > facebookchannellist1

sed '1d' facebookchannellist1 > facebookchannellist


while read line
do
   if [ -n "$line" ];then
      echo -n "$line," >> channels
   fi
done < facebookchannellist

cat channels | mutt -s "facebook channels location_feeder is not null(Maintanence)" fly.chen@BD.com -a facebookchannellist1 channels

rm facebookchannellist1
rm facebookchannellist
rm channels