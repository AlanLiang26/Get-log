Today=`date +%Y%m%d`

odps sql "drop table video_name_alan"

odps sql "create table if not exists video_name_alan (wid string,name string,url string);"

odps sql "insert overwrite table video_name_alan select a.wid,a.title,a.url from meta_video a  join (select distinct v  from body_slv where ctime=to_char(dateadd(getdate(), -1, 'dd'), 'yyyy-mm-dd')) b on a.wid=b.v;"

dship download video_name_alan /home/hdfs/data/search_analysis/video_name${Today}.txt


