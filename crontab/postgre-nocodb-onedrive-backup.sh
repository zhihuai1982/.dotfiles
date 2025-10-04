#!/bin/bash

# --------------------------------------------------------------------
# PostgreSQL 数据库定期备份脚本 (多数据库版)
# 适用于 Docker 环境下的 PostgreSQL 容器
# --------------------------------------------------------------------

# 配置参数
CONTAINER_NAME="postgres"                            # PostgreSQL 容器名
DB_USER="zhihuai1982"                                # 数据库用户名
DB_PASSWORD="pg-password"                            # 数据库密码
DB_NAMES=("otology-db" "nocodb-db")                  # 【修改】要备份的数据库名称列表
BACKUP_DIR="/home/zhihuai1982/Dockers/pgsql/pg-sync" # 备份目录
RETENTION_DAYS=7                                     # 备份保留天数

# 确保备份目录存在
mkdir -p "$BACKUP_DIR" || {
  echo "无法创建备份目录: $BACKUP_DIR"
  exit 1
}

# 检查容器是否运行
if ! docker ps | grep -q "$CONTAINER_NAME"; then
  echo "错误: PostgreSQL 容器 '$CONTAINER_NAME' 未运行"
  exit 1
fi

# 导出数据库密码，供后续命令使用
export PGPASSWORD="$DB_PASSWORD"

# 【修改】循环遍历所有数据库进行备份
for DB_NAME in "${DB_NAMES[@]}"; do
  echo "----------------------------------------"
  echo "开始备份数据库: $DB_NAME"

  TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)                     # 时间戳
  BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql.gz" # 备份文件名

  # 执行备份
  if docker exec -e PGPASSWORD="$DB_PASSWORD" -t "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" | gzip >"$BACKUP_FILE"; then
    echo "备份成功: $BACKUP_FILE"
  else
    echo "备份失败: $BACKUP_FILE"
    # 如果一个库备份失败，可以选择跳过继续下一个，这里我们选择继续
    continue
  fi

  # 清理旧备份
  echo "开始清理 '$DB_NAME' 的旧备份..."
  find "$BACKUP_DIR" -type f -name "${DB_NAME}_*.sql.gz" -mtime +"$RETENTION_DAYS" -print -delete
  echo "旧备份清理完毕."
done

echo "----------------------------------------"
echo "所有数据库备份完成."

# 同步整个备份目录到云端
echo "开始同步备份到 OneDrive..."
rclone sync "$BACKUP_DIR" onedrive-backup:PostgreSQLBackup
echo "同步完成."

# 发送心跳信号
echo "发送心跳信号到 Healthchecks.io..."
curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/587cab59-f8d9-41f3-bf41-89104a91c01b
echo "操作完成."

# -------------------------------------------------------
# 还原方法
# -------------------------------------------------------
#
#  1. 确保容器已启动。
#
#  2. (可选) 如果数据库正在使用，终止所有活跃连接以防还原失败。
#     将下面的 'your-db-name' 替换为你要还原的数据库名 (例如 otology-db)。
#     docker exec -it postgres psql -U zhihuai1982 -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='your-db-name' AND pid <> pg_backend_pid();"
#
#  3. 执行还原命令。
#     选择对应的备份文件和数据库名。
#
#     还原 otology-db 的示例:
#     PGPASSWORD=pg-password sh -c 'gunzip -c /path/to/pg-sync/otology-db_2025-09-10_02-30-00.sql.gz | docker exec -e PGPASSWORD=pg-password -i postgres psql -U zhihuai1982 -d otology-db'
#
#     还原 nocodb-db 的示例:
#     PGPASSWORD=pg-password sh -c 'gunzip -c /path/to/pg-sync/nocodb-db_2025-09-10_02-30-01.sql.gz | docker exec -e PGPASSWORD=pg-password -i postgres psql -U zhihuai1982 -d nocodb-db'
#
