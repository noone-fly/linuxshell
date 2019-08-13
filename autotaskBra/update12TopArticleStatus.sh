#!/bin/sh

#Get article list: sohu.women, ELLE.women, self, raily, 163lady, 55bbs, rosebeauty, pclady, onlylady,
mysql -h 192.168.51.102 -ufly.chen -pg5nxrj?kN- -e "SELECT id,url,channel_id FROM BD.Article WHERE datetime_posted>DATE_ADD(CURDATE(),INTERVAL -1 MONTH) AND channel_id in(544898830,544019914,202488758,545791520,545713409,545749553,550598085,543958826,205656583,522786409,545666498,545828529)" > files/other_topchannel_article_list1
sed '1d' files/other_topchannel_article_list1 > files/other_topchannel_article_list2.csv

while read line
do
   channel_id=`echo $line | awk '{print $3}'`
   if [ -n "$channel_id" ];then

      #1, club.women.sohu.com
      if [ "$channel_id" = "544898830" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            page_line=`grep 'class="total"' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'class="total">' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/544898830/$number_comments 544898830/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #2, club.ellechina.com
      if [ "$channel_id" = "544019914" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            page_line=`grep 'class="last"' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'lass="last">... ' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/544019914/$number_comments 544019914/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #3, bbs.self.com (UTF-8 http://bbs.self.com.cn/thread-311820-1-1.html)
      if [ "$channel_id" = "202488758" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            page_line=`grep 'class="last">\.\.\.' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'lass="last">... ' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/202488758/$number_comments 202488758/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #4, bbs.rayli.com.cn (GBK http://bbs.rayli.com.cn/thread-51623864-1-1.html)
      if [ "$channel_id" = "545791520" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GBK..u8 files/other_top_channels_page_html.html
            page_line=`grep 'class="last">\.\.\.' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'lass="last">... ' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/545791520/$number_comments 545791520/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #5 bbs.pclady.com.cn (GBK http://bbs.pclady.com.cn/topic-1213047.html)
      if [ "$channel_id" = "545713409" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GBK..u8 files/other_top_channels_page_html.html
            page_line=`grep 'class="next"' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F '
               page_num=`echo $option1 | awk -F '.html">' '{print $NF}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/545713409/$number_comments 545713409/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #6 bbs.55bbs.com  (gbk http://bbs.55bbs.com/thread-4389147-1-1.html)
      if [ "$channel_id" = "545749553" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GBK..u8 files/other_top_channels_page_html.html
            page_line=`grep 'class="next"' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F '.html">' '{print $NF}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/545749553/$number_comments 545749553/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #7 rosebeauty.com.cn (utf-8 http://www.rosebeauty.com.cn/bbs/lancome_bbs_344963.html)
 #     if [ "$channel_id" = "550598085" ];then
 #        article_id=`echo $line | awk '{print $1}'`
 #        echo "===article_id=============$article_id=========="
 #        article_url=`echo $line | awk '{print $2}'`
 #        if [ -n "$article_id" ] && [ -n "$article_url" ];then
#            httpcode=`curl -o /dev/null -s -w %{http_code} $article_url`
#            if [ "$httpcode" = "000" ];then
#               echo "httpcode: $httpcode, article_url: $article_url" >> 12TopChannelInvalidArticleUrl
#               page_num="Invalid_Article_Url"
#            elif [ "$httpcode" -ge "400" ];then
#               echo "httpcode: $httpcode, article_url: $article_url" >> 12TopChannelInvalidArticleUrl
#               page_num="Invalid_Article_Url"
#            else
               #get max page number from web page
 #              wget -q $article_url -O files/other_top_channels_page_html.html
 #              # recode GBK..u8 files/other_top_channels_page_html.html
 #              page_line=`grep 'class="current"' files/other_top_channels_page_html.html | head -1`
 #              if [ -n "$page_line" ];then
 #                 option1=`echo $page_line | awk -F 'javascript:;' '{print $NF}'`
 #                 option2=`echo $option1 | awk -F '.html">' '{print $2}'`
 #                 page_num=`echo $option2 | awk -F '<' '{print $1}'`
 #              else
 #                 page_num="NULL"
 #              fi
#            fi

            #get number of comment pages from DB
 #           echo $article_id > files/url_other_top_channel.txt
 #           awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
 #           page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
 #           echo $article_id > files/url_other_top_channel1.txt
 #           awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
 #           number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

 #           if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
 #              echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/550598085/$number_comments 550598085/" >> files/other_top_channel_next.csv
 #           fi
 #        fi
 #     fi

      #8 bbs.onlylady.com (GBK)
      if [ "$channel_id" = "543958826" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GBK..u8 files/other_top_channels_page_html.html
            page_line=`grep 'class="last">\.\.\.' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'lass="last">... ' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/543958826/$number_comments 543958826/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #9 kimiss.com (GBK)
      if [ "$channel_id" = "205656583" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GBK..u8 files/other_top_channels_page_html.html
            page_line=`grep 'class="last">\.\.\.' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'lass="last">... ' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/205656583/$number_comments 205656583/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #10 19lou.com GBK
      if [ "$channel_id" = "522786409" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GBK..u8 files/other_top_channels_page_html.html
            page_line=`grep '>\.\.\.' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F '>\.\.\.' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/522786409/$number_comments 522786409/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #11  club.eladies.sina.com.cn   (GB2312)
      if [ "$channel_id" = "545666498" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GB2312..u8 files/other_top_channels_page_html.html
            page_line=`grep 'class="last">\.\.\.' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F 'lass="last">... ' '{print $2}'`
               page_num=`echo $option1 | awk -F '<' '{print $1}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/545666498/$number_comments 545666498/" >> files/other_top_channel_next.csv
            fi
         fi
      fi

      #12 bbs.lady.163.com
      if [ "$channel_id" = "545828529" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo "===article_id=============$article_id=========="
         article_url=`echo $line | awk '{print $2}'`
         if [ -n "$article_id" ] && [ -n "$article_url" ];then
            #get max page number from web page
            wget -q $article_url -O files/other_top_channels_page_html.html
            recode GB2312..u8 files/other_top_channels_page_html.html
            page_line=`grep '>>' files/other_top_channels_page_html.html | head -1`
            if [ -n "$page_line" ];then
               option1=`echo $page_line | awk -F '.html">' '{print $1}'`
               page_num=`echo $option1 | awk -F ',' '{print $2}'`
            else
               page_num="NULL"
            fi

            #get number of comment pages from DB
            echo $article_id > files/url_other_top_channel.txt
            awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel.txt > files/url_other_top_channel.sql
            page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel.sql`

            #get number of comments from DB
            echo $article_id > files/url_other_top_channel1.txt
            awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_other_top_channel1.txt > files/url_other_top_channel1.sql
            number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_other_top_channel1.sql`

            if [ -n "$page_num" ] && [ -n "$page_comments" ] && [ -n "$number_comments" ];then
               echo $line | sed "s/http/$page_num http/" | sed "s/html/html $page_comments/" | sed "s/545828529/$number_comments 545828529/" >> files/other_top_channel_next.csv
            fi
         fi
      fi


   fi
done < files/other_topchannel_article_list2.csv


while read line
do
   option2=`echo $line | awk '{print $2}'`
   if [ "$option2" != "NULL" ];then
      option4=`echo $line | awk '{print $4}'`
      VALUE=`expr $option2 - $option4`
      if [ "$VALUE" -gt "6" ];then
          article_id=`echo $line | awk '{print $1}'`
          echo $article_id > files/url_update12TopArticle.txt
          awk '{print "UPDATE BD.Article SET status=2 WHERE id="$0""}' files/url_update12TopArticle.txt > files/url_update12TopArticle.sql
          echo -n "`date '+%Y-%m-%d %H:%M:%S'` " >> files/update12TopArticle.sql
          cat files/url_update12TopArticle.sql >> files/update12TopArticle.sql
          mysql -h 192.168.51.102 -ufly.chen -pg5nxrj?kN- -Bs < files/url_update12TopArticle.sql
      fi
   fi
done < files/other_top_channel_next.csv

rm files/other_top_channel_next.csv
