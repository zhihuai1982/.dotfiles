#!/bin/bash

# 备份 influxdb 数据库
# docker exec命令加上-it参数表示要打开启一个终端，而在后台任务中无法操作终端的，所以肯定不能执行。
# 解决方法就是去掉任务命令中的-it即可。
docker exec -u 1000:1000 influxdb influx backup /var/lib/influxdb2/onedrive-sync

# 需要打包的文件夹路径
folder="/home/zhihuai1982/Dockers/influxDB/influxdb-data/onedrive-sync/"

# 今天的日期，格式为YYYYMMDD
today=$(date +"%Y%m%d")
time=$(date +"%H-%M-%S")

# 打包指定文件夹下以今天日期开头的所有文件
tar -czvPf "${folder}${today}_${time}_backup.tar.gz" "${folder}${today}T"* --remove-files

# 删除7天之前的打包文件（只保留最近7天的打包文件）
find "${folder}" -maxdepth 1 -name '*_backup.tar.gz' -mtime +7 -delete

# 同步到 onedrive
rclone sync "${folder}" onedrive-backup:InfluxdbBackup

curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/1c942420-a9fb-48c2-a145-025bb2636117
