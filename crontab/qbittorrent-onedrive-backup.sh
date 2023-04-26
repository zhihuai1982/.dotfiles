#!/bin/bash

# 需要打包的文件夹路径
syncfolder="/home/zhihuai1982/Dockers/qBittorrent/qb-sync/"
datafolder="/home/zhihuai1982/Dockers/qBittorrent/qb-config/qBittorrent"

# 今天的日期，格式为YYYYMMDD
today=$(date +"%Y%m%d")
time=$(date +"%H-%M-%S")

# 打包指定文件夹下以今天日期开头的所有文件
tar -czvPf "${syncfolder}${today}_${time}_qbittorrentbackup.tar.gz" "${datafolder}"

# 删除7天之前的打包文件（只保留最近7天的打包文件）
find "${syncfolder}" -maxdepth 1 -name '*_qbittorrentbackup.tar.gz' -mtime +7 -delete

# 同步到 onedrive
rclone sync "${syncfolder}" onedrive-backup:QbittorrentBackup

curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/ba539dc3-66ef-40f7-90d3-e723e07e1183
