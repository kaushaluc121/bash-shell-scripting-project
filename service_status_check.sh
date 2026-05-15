#!/bin/bash
set -euo pipefail

SERVICES=(nginx docker sshd)

for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "$service is running"
    else
        echo "$service is down"
        systemctl restart "$service"
    fi
done
