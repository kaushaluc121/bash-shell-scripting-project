#!/bin/bash

# Check threshold argument
if [ "$#" -ne 1 ]; then
    echo "Usage: bash Disk_used.sh <threshold>"
    exit 1
fi

threshold="$1"

# Validate threshold is a number
if ! [[ "$threshold" =~ ^[0-9]+$ ]]; then
    echo "ERROR: Threshold must be a number"
    exit 1
fi

# Validate threshold range
if [ "$threshold" -lt 0 ] || [ "$threshold" -gt 100 ]; then
    echo "ERROR: Threshold must be between 0 and 100"
    exit 1
fi
# Get root filesystem disk usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# Check whether disk usage was retrieved
if [ -z "$disk_usage" ]; then
    echo "ERROR: Unable to determine disk usage"
    exit 1
fi

# Compare disk usage with threshold
if [ "$disk_usage" -gt "$threshold" ]; then
    echo "Disk is CRITICAL"
    exit 2
else
    echo "Disk is OK"
    exit 0
fi

