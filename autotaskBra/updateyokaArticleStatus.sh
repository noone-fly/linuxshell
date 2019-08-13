#!/bin/sh

#Get article list
mysql -h 192.168.51.102 -ufly.chen -pg5nxrj?kN- -e "SELECT id,url,channel_id FROM BD.Article WHERE datetime_posted>DATE_ADD(CURDATE(),INTERVAL -2 MONTH) AND channel_id=543793180 ORDER BY id" > files/update_yoka_article1
sed '1d' files/update_yoka_article1 > files/update_yoka_article2

while read line
do
   article_id=`echo $line | awk '{print $1}'`
   article_url=`echo $line | awk '{print $2}'`
   if [ -n "$article_id" ] && [ -n "$article_url" ];then
      wget -q $article_url -O files/article_page_html.html
      #recode utf-8
      page_line=`grep 'class="dw"' files/article_page_html.html | head -1`
      str_last=`grep 'class="last"' files/article_page_html.html | head -1`
      if [ -n "$str_last" ];then
         str2=`echo $str_last | awk -F 'class="last"> ' '{print $2}'`
         page_num=`echo $str2 | awk -F '<' '{print $1}'`
      else
         page_num="N.A."
      fi

      #SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id
      echo $article_id > files/url_yoka.txt
      awk '{print "SELECT COUNT(DISTINCT(url)) FROM BD.Comment where article_id="$0""}' files/url_yoka.txt > files/url_yoka.sql
      page_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_yoka.sql`

      echo $article_id > files/url_yoka1.txt
      awk '{print "SELECT COUNT(id) FROM BD.Comment where article_id="$0""}' files/url_yoka1.txt > files/url_yoka1.sql
      number_comments=`mysql -h 192.168.51.103 -ufly.chen -pg5nxrj?kN- -Bs < files/url_yoka1.sql`

      if [ -n "$page_comments" ] && [ -n "$page_num" ];then
         echo $line | sed "s/http/$page_comments http/" | sed "s/543793180/$page_num 543793180/" | sed "s/html/html $number_comments/" >> files/update_yoka_article3.csv
      fi
   fi
done < files/update_yoka_article2

while read line
do
   web_page_num=`echo $line | awk '{print $5}'`
   if [ "$web_page_num" != "N.A." ];then
      option2=`echo $line | awk '{print $2}'`
      VALUE=`expr $web_page_num - $option2`
#echo "============VALUE==================================$VALUE"
      if [ "$VALUE" -gt "4" ];then
         article_id=`echo $line | awk '{print $1}'`
         echo $article_id > files/url_updateyokaarticle.txt
         awk '{print "UPDATE BD.Article SET status=2 WHERE id="$0""}' files/url_updateyokaarticle.txt > files/url_updateyokaarticle.sql
         echo -n "`date '+%Y-%m-%d %H:%M:%S'` " >> files/updateYokaArticle.sql
         cat files/url_updateyokaarticle.sql >> files/updateYokaArticle.sql
         mysql -h 192.168.51.102 -ufly.chen -pg5nxrj?kN- -Bs < files/url_updateyokaarticle.sql
      fi
   fi
done < files/update_yoka_article3.csv

rm files/update_yoka_article3.csv