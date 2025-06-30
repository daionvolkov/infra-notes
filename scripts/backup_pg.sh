#!/bin/bash

# === Settings ===

# Параметры базы
PG_CONTAINER_NAME="postgres_container"   # Name or ID Docker-container с PostgreSQL
PG_USER="postgres"
PG_DB="your_database_name"

# Backup`s filder on the host`
BACKUP_DIR="/opt/db_backups/backups"

# Number of days to keep backups
RETENTION_DAYS=7

# Telegram notifications
BOT_TOKEN="your_bot_token"
CHAT_ID="your_chat_id"
SERVER_IP="192.168.1.100"

# === Create a folder if not available ===
mkdir -p "$BACKUP_DIR"

# Form a file name with date
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_${PG_DB}_${DATE}.sql.gz"

# === Create backup ===
docker exec "$PG_CONTAINER_NAME" pg_dump -U "$PG_USER" "$PG_DB" | gzip > "$BACKUP_FILE"

# Check for success
if [ $? -eq 0 ]; then
    MSG="✅ Backup completed successfully: $(basename "$BACKUP_FILE")"
else
    MSG="❌ Backup FAILED for database $PG_DB"
fi

# === Delete old backups ===
find "$BACKUP_DIR" -type f -mtime +"$RETENTION_DAYS" -name "*.gz" -exec rm -f {} \;

# === Send notification to Telegram ===
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="[$SERVER_IP] $MSG"

