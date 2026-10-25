#!/bin/bash

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "ERROR: 2 or 3 arguments are required"
    echo "Usage: $0 <LOG_PATH> <RETENTION> [--dry-run]"
    exit 1
fi



LOG_PATH="$1"
RETENTION="$2"
MODE="$3"

if [[ ! "$RETENTION" =~ ^[0-9]+$ ]]; then
    echo "ERROR: Retention must be a number"
    exit 1
fi

 if [ ! -d "$LOG_PATH" ]; then
	echo "$LOG_PATH does not exits"
	exit 1
else
	echo " exist"
fi

if [ -n "$MODE" ] && [ "$MODE" != "--dry-run" ]; then
    echo "ERROR: Invalid option: $MODE"
    echo "Usage: $0 <LOG_PATH> <RETENTION> [--dry-run]"
    exit 1
fi



COUNT=$(find "$LOG_PATH" -type f -name "*.log" -mtime +"$RETENTION" | wc -l)

if [ "$COUNT" -eq 0 ]; then
    echo "[INFO] No old log files found"
else
    echo "[INFO] $COUNT old log files found"
fi


read -p "Delete these files? [y/N]: " choice 

if [ "$choice" = "y" ]; then 
     
       echo "[INFO] Deleting old log files..." 
       	
	find "$LOG_PATH" -type f -name "*.log" -mtime +$RETENTION -delete 
	

echo "[INFO] Old log files deleted" else echo "[INFO] Deletion cancelled" 

fi
