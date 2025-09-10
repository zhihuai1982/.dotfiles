#!/bin/bash

# -------------------------------------------------------
# PostgreSQL 数据库定期备份脚本（简化版）
# 适用于 Docker 环境下的 PostgreSQL 容器
# -------------------------------------------------------

# 配置参数
CONTAINER_NAME="postgres"                                # PostgreSQL 容器名
DB_USER="zhihuai1982"                                    # 数据库用户名
DB_PASSWORD="pg-password"                                # 数据库密码
DB_NAME="otology-db"                                     # 数据库名称
BACKUP_DIR="/home/zhihuai1982/Dockers/pgsql/pg-sync"     # 备份目录（相对于脚本位置）
RETENTION_DAYS=7                                         # 备份保留天数
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)                     # 时间戳
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql.gz" # 备份文件名

# 确保脚本从其所在目录执行
# cd "$(dirname "$0")" || { echo "无法切换到脚本目录"; exit 1; }

# 创建备份目录（如果不存在）
# mkdir -p "$BACKUP_DIR" || { echo "无法创建备份目录: $BACKUP_DIR"; exit 1; }

# 检查容器是否运行
if ! docker ps | grep -q "$CONTAINER_NAME"; then
  echo "错误: PostgreSQL 容器 '$CONTAINER_NAME' 未运行"
  exit 1
fi

# 执行备份
export PGPASSWORD="$DB_PASSWORD"
if docker exec -e PGPASSWORD="$DB_PASSWORD" -t "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" | gzip >"$BACKUP_FILE"; then
  echo "备份成功: $BACKUP_FILE"
else
  echo "备份失败: $BACKUP_FILE"
  exit 1
fi

# 清理旧备份
find "$BACKUP_DIR" -type f -name "${DB_NAME}_*.sql.gz" -mtime +"$RETENTION_DAYS" -delete

rclone sync "$BACKUP_DIR" onedrive-backup:PostgreSQLBackup

curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/587cab59-f8d9-41f3-bf41-89104a91c01b

# 还原方法
#
#  1. 容器启动
#  2. 终止可能得活跃连接(重新还原 docker 就不需要)
#  docker exec -it postgres psql -U zhihuai1982 -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='otology-db' AND pid <> pg_backend_pid();"
#  3. 还原命令
#  PGPASSWORD=pg-password sh -c 'gunzip -c ./pg-sync/otology-db_2025-09-10_02-30-00.sql.gz | docker exec -e PGPASSWORD=pg-password -i postgres psql -U zhihuai1982 -d otology-db'
