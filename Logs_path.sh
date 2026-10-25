#!/bin/bash

LOG_PATH="/var/log/myapp/application.log"

find $LOG_PATH -type f -mtime +15 | wc -l 

if [[ ! -f "$LOG_PATH" ]]; then
    echo "ERROR: File missing or not a regular file"
    exit 1
fi

if [ -r "$LOG_PATH" ]; then
    echo "Readable"
else
    echo "Not Readable"
fi
 exit 1
