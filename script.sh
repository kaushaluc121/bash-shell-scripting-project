
#!/bin/bash

SOURCE="$HOME/backup_test"
BACKUP_DIR="$HOME/my_backups"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Get source directory name
SOURCE_NAME=$(basename "$SOURCE")

# Create backup file name
BACKUP_FILE="$BACKUP_DIR/${SOURCE_NAME}_backup_${TIMESTAMP}.tar.gz"

echo "Source: $SOURCE"
echo "Backup file: $BACKUP_FILE"

# Create compressed backup
tar -czf "$BACKUP_FILE" "$SOURCE"

# Check tar command status
if [ $? -eq 0 ]; then
    echo "[OK] Backup created successfully"
else
    echo "[CRITICAL] Backup failed"
    exit 1
fi

# Verify backup file exists
if [ -f "$BACKUP_FILE" ]; then
    echo "[OK] Backup file exists"
else
    echo "[CRITICAL] Backup file not found"
    exit 1
fi

echo "Backup completed successfully."


