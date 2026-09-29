#!/bin/bash

check_disk() {
	local path=$1
	echo "checking disk usage"
	df -h "$path"
if [ ! -d "$path" ]; then
	echo "ERROR Directory does not exit: $path"
	return 2
fi

	echo "checking disk usage for $path"

#check argument exits or not 

if [ -z "$1" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

}
check_disk "$1"
