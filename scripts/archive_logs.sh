#!/bin/bash

# Setting
LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/archive"
RETENTION_DAYS=14

# Create a folder for archives
mkdir -p "$ARCHIVE_DIR"

DATE=$(date +"%Y-%m-%d")
ARCHIVE_FILE="$ARCHIVE_DIR/logs_$DATE.tar.gz"

# Archive logs
tar -czf "$ARCHIVE_FILE" -C "$LOG_DIR" .

if [ $? -eq 0 ]; then
  MSG="✅ Архивирование логов успешно: $(basename "$ARCHIVE_FILE")"
else
  MSG="❌ Ошибка при архивировании логов"
fi

# Delete old archives
find "$ARCHIVE_DIR" -type f -mtime +"$RETENTION_DAYS" -name "*.tar.gz" -exec rm -f {} \;

# Send notification to Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="$MSG"
