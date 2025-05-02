#!/bin/bash

# Set variables
BACKUP_DIR="/home/zhihuai1982/Dockers/nocodb"
DOCKER_DIR="${BACKUP_DIR}"  # Directory where docker-compose.yml is located
SYNC_DIR="${BACKUP_DIR}/nocodb-sync"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SYNOLOGY_SERVER="192.168.1.23"
SYNOLOGY_USER="rsync-user"
SYNOLOGY_PATH="/volume1/nocodb-sync"
RSYNC_PASSWORD="Rsync1206"  # Replace with your actual password
HEALTHCHECK_URL="https://hc-ping.com/587cab59-f8d9-41f3-bf41-89104a91c01b"
RETENTION_DAYS=7  # Number of days to keep backups

# Create sync directory if it doesn't exist
mkdir -p ${SYNC_DIR}

# Export database in Tar format
echo "Exporting database..."
# Change to the directory containing docker-compose.yml before executing docker compose command
cd ${DOCKER_DIR} && docker compose exec -T root_db pg_dump -U postgres -d root_db -Ft > ${BACKUP_DIR}/${TIMESTAMP}_db-data_backup.tar

# Check if database export was successful
if [ $? -eq 0 ]; then
    echo "Database export successful"
    # Copy database backup to sync directory
    cp ${BACKUP_DIR}/${TIMESTAMP}_db-data_backup.tar ${SYNC_DIR}/
else
    echo "Database export failed"
    # Send failure notification to healthcheck
    curl -m 10 --retry 5 --data-raw "Database export failed" ${HEALTHCHECK_URL}/fail
    exit 1
fi

# Backup nc-data folder
echo "Backing up nc-data folder..."
tar -cvf ${SYNC_DIR}/${TIMESTAMP}_nc-data_backup.tar -C ${BACKUP_DIR}/nc-data/ .

# Check if nc-data backup was successful
if [ $? -eq 0 ]; then
    echo "nc-data backup successful"
else
    echo "nc-data backup failed"
    # Send failure notification to healthcheck
    curl -m 10 --retry 5 --data-raw "nc-data backup failed" ${HEALTHCHECK_URL}/fail
    exit 1
fi

# Clean up old backup files (keep only files from the last RETENTION_DAYS days)
echo "Cleaning up old backup files..."
find ${SYNC_DIR} -name "*_db-data_backup.tar" -type f -mtime +${RETENTION_DAYS} -delete
find ${SYNC_DIR} -name "*_nc-data_backup.tar" -type f -mtime +${RETENTION_DAYS} -delete
echo "Cleanup completed, files older than ${RETENTION_DAYS} days have been removed"

# Sync to Synology NAS using sshpass for password authentication
echo "Syncing to Synology NAS..."
export SSHPASS="${RSYNC_PASSWORD}"
sshpass -e rsync -rlptD --chmod=ugo=rwX --info=progress2 --delete ${SYNC_DIR}/ ${SYNOLOGY_USER}@${SYNOLOGY_SERVER}:${SYNOLOGY_PATH}

# Use a more lenient check for rsync
RSYNC_EXIT=$?
if [ $RSYNC_EXIT -eq 0 ]; then
    echo "Sync to Synology NAS completed successfully"
elif [ $RSYNC_EXIT -eq 23 ]; then
    echo "Sync to Synology NAS completed with some attribute/permission warnings (code 23)"
    echo "This is usually not critical - files were transferred but some attributes couldn't be set"
    # Don't exit with error for code 23
else
    echo "Sync to Synology NAS failed with exit code $RSYNC_EXIT"
    # Send failure notification to healthcheck
    curl -m 10 --retry 5 --data-raw "Sync to Synology NAS failed with exit code $RSYNC_EXIT" ${HEALTHCHECK_URL}/fail
    exit 1
fi

echo "Backup completed successfully at $(date)"

# Send success notification to healthcheck
echo "Sending healthcheck ping..."
curl -m 10 --retry 5 ${HEALTHCHECK_URL}

