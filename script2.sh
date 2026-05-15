#!/bin/bash

# Find all log files from yesterday
find /Users/kaushal/logs -name "*.log" -mtime -1

# Search for ERROR in a log file
grep "ERROR" /Users/nana/kaushal/application.log

# Count how many errors are in the file
grep -c "ERROR" /Users/nana/kaushal/application.log

# Find the most recent error
grep "ERROR" /Users/kaushal/logs/application.log | tail -1

# Look for FATAL errors in another log file
grep "FATAL" /Users/kaushal/logs/system.log

# Count FATAL errors
grep -c "FATAL" /Users/kaushal/logs/system.log

