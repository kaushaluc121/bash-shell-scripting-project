#!/bin/bash

LOG_PATH=/tmp/app_logs

COUNT=$(find "$LOG_PATH" -type f -name "*.log" -mtime +7 | wc -l)

if [ "$COUNT" -eq 0 ]; then
    echo "[INFO] No old log files found"
else
    echo "[INFO] $COUNT old log files found"
fi
