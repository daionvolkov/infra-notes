#!/bin/bash

# Options (customize to your environment)
BACKUP_DIR="/var/backups/postgres"
RETENTION_DAYS=7
DB_NAME="your_database"
DB_USER="postgres"

mkdir -p "$BACKUP_DIR"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_$DATE.sql.gz"

# Create dump and archive
pg_dump -U "$DB_USER" "$DB_NAME" | gzip > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
  echo "✅ Backup created: $BACKUP_FILE"
else
  echo "❌ Backup failed!"
fi

# Delete archives older than RETENTION_DAYS
find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -name "*.sql.gz" -exec rm -f {} \;
