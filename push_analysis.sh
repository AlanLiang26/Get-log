Today=`date +%Y%m%d`

odps sql "drop table push_action_analysis"
odps sql "drop table push_expo_analysis"
odps sql "drop table video_name_alan"

odps sql "create table if not exists push_action_analysis (server_time string,sid string,uid string,app string,profile string,ts string,n string,v string,nfrom string,action string,type string,ctag string,ntype string,uinfo string,pts string);"

odps sql "insert overwrite table push_action_analysis select server_time,sid,uid,app,profile,ts,n,v,nfrom,action,type,ctag,ntype,uinfo,pts from body_clv  where type='1' and ctime=to_char(dateadd(getdate(), -1, 'dd'), 'yyyy-mm-dd');"

dship download push_action_analysis /home/hdfs/data/search_analysis/push_action${Today}.txt

odps sql "create table if not exists push_expo_analysis (server_time string,sid string,uid string,app string,profile string,ts string,n string,wid string,nfrom string,type string,v string,ctag string,ntype string,uinfo string,pts string);"

odps sql "insert overwrite table push_expo_analysis select server_time,sid,uid,app,profile,ts,n,wid,nfrom,type,v,ctag,ntype,uinfo,pts from body_slv  where type='1' and ctime=to_char(dateadd(getdate(), -1, 'dd'), 'yyyy-mm-dd')"

dship download push_expo_analysis /home/hdfs/data/search_analysis/push_expo${Today}.txt

odps sql "create table if not exists video_name_alan (wid string,name string,url string);"

odps sql "insert overwrite table video_name_alan select a.wid,a.title,a.url from meta_video a  join (select distinct v  from push_expo_analysis) b on a.wid=b.v;"

dship download video_name_alan /home/hdfs/data/search_analysis/video_name${Today}.txt
