-m OPERATION -t crawler
-m OPERATION -t feeder
ps -ef | grep "OPERATION .. feeder" | awk '{print $2}'
ps -ef | grep "OPERATION .. crawler" | awk '{print $2}'
ps -ef | grep "OPERATION .. monitor" | awk '{print $2}'

50.17
#feeder TOP channels
#0 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 * * * cd /BD/maintance-fly/feeder && ./multipleTask.sh feeder > /dev/null 2>&1
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58 * * * * cd /BD/maintance-fly/feeder && ./listener_feed.sh > /dev/null 2>&1
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58 * * * * cd /BD/maintance-fly/feeder && ./listener_crawl.sh > /dev/null 2>&1
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58 * * * * cd /BD/maintance-fly/feeder && ./listener_debug.sh > /dev/null 2>&1