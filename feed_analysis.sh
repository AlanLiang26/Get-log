source ~/.bash_profile
Today=`date +%Y%m%d`

odps sql "drop table recom_feed_action_analysis"
odps sql "drop table recom_feed_expo_analysis"
odps sql "drop table recom_feed_header_analysis"

odps sql "create table if not exists recom_feed_action_analysis (server_time string,sid string,uid string,app string,profile string,ts string,n string,wid string,tid string,sd string,dd string,h string,ctag string,seq string,refer string,uinfo string,type string);"

odps sql "insert overwrite table recom_feed_action_analysis select server_time,sid,uid,app,profile,ts,n,wid,tid,sd,dd,h,ctag,seq,refer,uinfo,type from body_st  where ctime=to_char(dateadd(getdate(), -1, 'dd'), 'yyyy-mm-dd') and parse_int(sd)>3000 and refer like 'phome_2%';"

dship download recom_feed_action_analysis /home/hdfs/data/search_analysis/recom_feed_action${Today}.txt

odps sql "create table if not exists recom_feed_expo_analysis (server_time string,sid string,uid string,app string,profile string,ts string,n string,wids string,refer string,refercid string,tids string,rseq string,uinfo string,ctime string);"

odps sql "insert overwrite table recom_feed_expo_analysis select server_time,sid,uid,app,profile,ts,n,wids,refer,refercid,tids,rseq,uinfo,ctime from body_ldw  where ctime=to_char(dateadd(getdate(), -1, 'dd'), 'yyyy-mm-dd') and refer like 'phome_2%'"

dship download recom_feed_expo_analysis /home/hdfs/data/search_analysis/recom_feed_expo${Today}.txt

odps sql "create table if not exists recom_feed_header_analysis (server_time string,sid string,app string,appv string);"

odps sql "insert overwrite table recom_feed_header_analysis select server_time, sid,app,appv from header where ctime=to_char(dateadd(getdate(),-1,'dd'),'yyyy-mm-dd') and app like 'general_video%';"

dship download recom_feed_header_analysis /home/hdfs/data/search_analysis/recom_feed_header${Today}.txt

