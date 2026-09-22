#!/bin/bash

SOURCE=/tmp/app_logs
BACKUP_DIR=/tmp/backups

if [ -d $SOURCE ]; then
	echo "back_dir exist"
else
	echo "Not exists"
fi
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

SOURCE_NAME=$(basename "$SOURCE")

BACKUP_FILE="$BACKUP_DIR/${SOURCE_NAME}_$TIMESTAMP.tar.gz"

echo "Source: $SOURCE"
echo "Backup file: $BACKUP_DIR"

tar -czf "$BACKUP_FILE" "$SOURCE"
#check tar command status

if [ $? -eq 0 ]; then
	echo "[OK] Backup created successfully"
else
	echo "[criitcal] backup failed"
fi

if [ -f $BACKUP_FILE ]; then
        echo "[OK] Backup file exisits"
else
        echo "[criitcal] not exits"
fi
