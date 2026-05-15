#!/bin/bash
set -euo pipefail

THRESHOLD=80
EMAIL="admin@example.com"
LOG_FILE="/var/log/disk_monitor.log"

log() {
    echo "$(date '+%F %T') : $1" | tee -a "$LOG_FILE"
}

while read -r line; do
    usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    partition=$(echo "$line" | awk '{print $6}')

    if [[ $usage -ge $THRESHOLD ]]; then
        msg="Disk usage on $partition is ${usage}%"
        log "$msg"
        echo "$msg" | mail -s "Disk Alert" "$EMAIL"
    fi

done < <(df -hP | grep '^/dev/')
