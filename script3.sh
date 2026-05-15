#!/bin/bash
LOG_DIR="/Users/kaushal/logs"
ERROR_PATTERNS=("ERROR" "FATAL" "CRITICAL")
echo -e "\n==========================================================="
echo "==== Analysing log files in $LOG_DIR directory ===="
echo "==========================================================="
echo -e "\n### List of log files updated in last 24 hours ###"
LOG_FILES=$(find "$LOG_DIR" -name "*.log" -mtime -1)
echo "$LOG_FILES"
# Loop through each log file
for LOG_FILE in $LOG_FILES; do
 echo -e "\n==================================================="
 echo "============ $LOG_FILE ============"
 echo "==================================================="

 echo -e "\n### searching ${ERROR_PATTERNS[0]} logs in $LOG_FILE ###"
 grep "${ERROR_PATTERNS[0]}" "$LOG_FILE"

 echo -e "\n### Number of ${ERROR_PATTERNS[0]} logs found ###"
 grep -c "${ERROR_PATTERNS[0]}" "$LOG_FILE"

 # Addition
done
