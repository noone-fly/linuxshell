#!/bin/sh
#author:fly
#build:2012-12-1
#params:task number

rm ChannelIDList_temp 2>/dev/null
./clearDuplicatedLine.sh
if [ $# -eq 0 ];then
    echo "The params are wrong, Try again please! (For example: assignChannelID.sh 12)"
    exit 0
fi

#assign channel
lines=`cat ChannelIDList | wc -l`
if [ "$lines" -eq "0" ];then
    cp ChannelIDList_next ChannelIDList 2>> files/assignchannelexception
    rm ChannelIDList_next
    cat ChannelIDList_prev >> ChannelIDList 2>> files/assignchannelexception
    # echo "ChannelIDList is empty(50.189)" | mutt -s "`date '+%Y-%m-%s %H:%M:%S '` ChannelIDList is empty(50.189Maintanence)" fly.chen@BD.com
    ./clearDuplicatedLine.sh
fi

if [ "$lines" -ne "0" ];then
    LOOP=0
    while read line
    do
        if [ -n "$line" ];then
            echo $line > files/url_debugfixchannel.txt
            awk '{print "SELECT COUNT(ID) FROM BD.Article WHERE status=5 AND channel_id="$0""}' files/url_debugfixchannel.txt > files/url_debugfixchannel.sql
            status5=`mysql -h 192.168.51.102 -ufly.chen -pg5nxrj?kN- -Bs < files/url_debugfixchannel.sql`
            if [ "$status5" -le "9" ];then
                # echo $line >> ChannelIDList_prev
                # sed -i "/${line}/d" ChannelIDList
            elif [ "$status5" -ge "10" ];then
                # echo $line >> ChannelIDList_next
                # echo $line >> ChannelIDList_temp
                LOOP=`expr $LOOP + 1`
                if [ "$LOOP" -gt "${1}" ];then
                    break
                fi
            else
                # echo $line >> ChannelIDList_prev
                # sed -i "/${line}/d" ChannelIDList
            fi
        fi
    done < ChannelIDList
fi
#sed -i "1,${LOOP}d" ChannelIDList