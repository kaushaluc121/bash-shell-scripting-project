#!/bin/bash
set -euo pipefail

SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backup"
DATE=$(date +%F-%H-%M)
BACKUP_FILE="$BACKUP_DIR/app_backup_$DATE.tar.gz"
RETENTION_DAYS=7

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -delete

echo "Backup completed: $BACKUP_FILE"
