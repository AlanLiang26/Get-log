Today=`date +%Y%m%d`

odps sql "drop table recom_feed_header_analysis"

odps sql "create table if not exists recom_feed_header_analysis (server_time string,sid string,app string,appv string);"

odps sql "insert overwrite table recom_feed_header_analysis select server_time, sid,app,appv from header where ctime=to_char(dateadd(getdate(),-1,'dd'),'yyyy-mm-dd') and app like 'general_video%';"

dship download recom_feed_header_analysis /home/hdfs/data/search_analysis/recom_feed_header${Today}.txt
