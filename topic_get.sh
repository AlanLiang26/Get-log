
Today=`date +%Y%m%d`



odps sql "drop table topic_name_alan"



odps sql "create table if not exists topic_name_alan (cid string,name string);"



odps sql "insert overwrite table topic_name_alan select cid,name from meta_topic;"



dship download topic_name_alan /home/hdfs/data/search_analysis/topic_name${Today}.txt


