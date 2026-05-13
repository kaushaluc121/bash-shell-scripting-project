#!/bin/bash

source ./config.sh

DATE=$(date '+%Y-%m-%d %H:%M:%S')

log_message() {
    echo "$DATE : $1" >> $LOG_FILE
}

# CPU Usage Check
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    log_message "HIGH CPU USAGE: $CPU_USAGE%"
fi

# Memory Check
MEM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}' | cut -d. -f1)

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    log_message "HIGH MEMORY USAGE: $MEM_USAGE%"
fi

# Disk Check
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    log_message "HIGH DISK USAGE: $DISK_USAGE%"
fi

# Service Monitoring
for service in "${SERVICES[@]}"
do
    systemctl is-active --quiet $service

    if [ $? -ne 0 ]; then
        log_message "$service is DOWN. Restarting..."

        systemctl restart $service

        if [ $? -eq 0 ]; then
            log_message "$service restarted successfully"
        else
            log_message "FAILED to restart $service"
        fi
    fi
done
