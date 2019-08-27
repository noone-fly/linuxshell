#!/bin/sh
#author:fly
#build:2012-12-1
#params:task number

rm ChannelIDList_temp 2>/dev/null
if [ $# -eq 0 ];then
    echo "The params are wrong, Try again please! (For example: assignChannelID.sh 12)"
    exit 0
fi

lines=`cat ChannelIDList | wc -l`

if [ "$lines" -ne "0" ];then
    LOOP=0
    while read line
    do
        if [ -n "$line" ];then
            echo "====$LOOP"
            echo $line
            echo $line >> ChannelIDList_temp
            LOOP=`expr $LOOP + 1`
            echo $LOOP
            if [ "$LOOP" -ge "${1}" ];then
                break
            fi
        fi
    done < ChannelIDList
fi
sed -i "1,${LOOP}d" ChannelIDList

cat ChannelIDList_temp >> ChannelIDList