#!/bin/bash

# === Настройки ===
LOG_DIRS=(
    "/opt/projects/log-o-matic/logs"
    "/opt/projects/buttonator/logs"
    "/opt/projects/buttonator_dev/logs"
    "/opt/projects/rocketpanel/logs"
)
DAYS_TO_KEEP=7

# Telegram
BOT_TOKEN="your_bot_token_here"
CHAT_ID="your_chat_id_here"
SERVER_IP="192.168.1.30"

# === Удаление логов ===
DELETED_FILES=""

for DIR in "${LOG_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        FILES=$(find "$DIR" -type f -mtime +$DAYS_TO_KEEP)
        if [ -n "$FILES" ]; then
            while IFS= read -r FILE; do
                rm -f "$FILE"
                DELETED_FILES+="$FILE"$'\n'
            done <<< "$FILES"
        fi
    fi
done

# === Telegram уведомление ===
if [ -n "$DELETED_FILES" ]; then
    MESSAGE="🧹 Log cleanup on $SERVER_IP: Removed logs older than $DAYS_TO_KEEP days:\n$DELETED_FILES"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$MESSAGE"
fi
