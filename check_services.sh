#!/bin/bash

# Agar koi argument pass na kiya gaya ho toh help message dikhayen
if [ $# -eq 0 ]; then
    echo "Usage: $0 <service_name1> [service_name2 ...]"
    echo "Example: $0 nginx tomcat"
    exit 1
fi

failed_count=0

echo "--- Checking Service Status ---"

# Loop ke zariye saare passed arguments ($@) ko check karna
for service in "$@"; do
    if systemctl is-active --quiet "$service"; then
        echo "[OK] $service is running."
    else
        echo "[CRITICAL] $service is NOT running!"
        ((failed_count++))
    fi
done

echo "--------------------------------"

# Agar ek bhi service failed hui toh Exit 1, warna Exit 0
if [ $failed_count -gt 0 ]; then
    echo "Total failed services: $failed_count"
    exit 1
else
    echo "All requested services are running fine."
    exit 0
fi

