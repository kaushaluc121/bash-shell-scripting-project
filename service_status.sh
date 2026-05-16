#!/bin/bash

service="nginx"

if ! service is-active --quite $service; then
	echo "$service is down restart"
	systemctl start $service
else
	echo "$service is running fine"
fi
