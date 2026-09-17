#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usgae: bash check_disk_arg.sh <warning> <critical>"
	exit 1
fi

disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
warning="$1"
critical="$2"

echo "warning: is $warning"
echo "critical is $critical"

if [ "$warning" -ge "$critical" ]; then
 
	   echo "ERROR: Warning threshold must be less than critical threshold"
           exit 1
fi



if ! [[ "$warning" =~ ^[0-9]+$ ]]; then
		    echo "ERROR: Warning threshold must be a number"
   		    exit 1
fi


		if ! [[ "$critical" =~ ^[0-9]+$ ]]; then
    		echo "ERROR: Critical threshold must be a number"
                 exit 1
fi

if [ "$warning" -lt 0 ] || [ "$warning" -gt 100 ]; then
    echo "ERROR: Warning threshold must be between 0 and 100"
    exit 1
fi

if [ "$critical" -lt 0 ] || [ "$critical" -gt 100 ]; then
    echo "ERROR: Critical threshold must be between 0 and 100"
    exit 1
fi

if [ "$disk_usage" -lt "$warning" ]; then
	echo "disk is OK"
	exit 0
elif [ "$disk_usage" -le "$critical" ]; then
	echo "Warning"
	exit 1
else
	echo "Disk is critical"
	exit 2
fi

