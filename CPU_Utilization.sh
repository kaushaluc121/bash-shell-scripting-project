#!/bin/bash

# -------------------------------------------------------------
# 1. Argument Validation
# -------------------------------------------------------------

if [ $# -ne 2 ]; then
    echo "Usage: $0 <WARNING_THRESHOLD> <CRITICAL_THRESHOLD>"
    echo "Example: $0 70 90"
    exit 1
fi

WARN_LIMIT=$1
CRIT_LIMIT=$2

# Check numeric values
if ! [[ "$WARN_LIMIT" =~ ^[0-9]+$ ]] || ! [[ "$CRIT_LIMIT" =~ ^[0-9]+$ ]]; then
    echo "ERROR: Thresholds must be integers."
    exit 1
fi

# Check range
if [ "$WARN_LIMIT" -gt 100 ] || [ "$CRIT_LIMIT" -gt 100 ]; then
    echo "ERROR: Threshold must be between 0 and 100."
    exit 1
fi

# Warning must be less than Critical
if [ "$WARN_LIMIT" -ge "$CRIT_LIMIT" ]; then
    echo "ERROR: WARNING must be less than CRITICAL."
    exit 1
fi


# -------------------------------------------------------------
# 2. Detect Operating System
# -------------------------------------------------------------

OS=$(uname -s)


# -------------------------------------------------------------
# 3. Calculate CPU Usage
# -------------------------------------------------------------

if [ "$OS" = "Darwin" ]; then

    # macOS
    cpu_idle=$(top -l 1 | grep "CPU usage" | awk -F',' '{print $3}' | awk '{print $1}' | tr -d '%')
    cpu_usage=$(awk "BEGIN {print 100 - $cpu_idle}")

elif [ "$OS" = "Linux" ]; then

    # Linux - use mpstat if available
    if command -v mpstat >/dev/null 2>&1; then

        cpu_idle=$(mpstat 1 1 | awk 'END {print $NF}')
        cpu_usage=$(awk "BEGIN {print 100 - $cpu_idle}")

    else

        # Linux fallback using /proc/stat
        read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

        total1=$((user + nice + system + idle + iowait + irq + softirq + steal))
        idle1=$((idle + iowait))

        sleep 1

        read cpu user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 guest_nice2 < /proc/stat

        total2=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
        idle2=$((idle2 + iowait2))

        total_diff=$((total2 - total1))
        idle_diff=$((idle2 - idle1))

        cpu_usage=$(awk "BEGIN {print (1 - $idle_diff / $total_diff) * 100}")

    fi

else

    echo "ERROR: Unsupported operating system: $OS"
    exit 1

fi


# -------------------------------------------------------------
# 4. Convert CPU Usage to Integer
# -------------------------------------------------------------

cpu_usage_int=$(printf "%.0f" "$cpu_usage")

echo "--------------------------------"
echo "Operating System : $OS"
echo "CPU Usage        : ${cpu_usage_int}%"
echo "Warning          : ${WARN_LIMIT}%"
echo "Critical         : ${CRIT_LIMIT}%"
echo "--------------------------------"


# -------------------------------------------------------------
# 5. Decision
# -------------------------------------------------------------

if [ "$cpu_usage_int" -gt "$CRIT_LIMIT" ]; then

    echo "[CRITICAL] CPU usage is high!"
    exit 2

elif [ "$cpu_usage_int" -ge "$WARN_LIMIT" ]; then

    echo "[WARNING] CPU usage is high!"
    exit 1

else

    echo "[OK] CPU usage is normal."
    exit 0

fi
