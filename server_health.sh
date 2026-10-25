#!/bin/bash

echo "===== SERVER HEALTH ====="

echo "----- Uptime / Load -----"
uptime

echo "----- CPU / Process -----"
top -b -n 1 | head -20

echo "----- Disk -----"
df -hP

echo "----- Memory -----"
free -m
