#!/bin/bash

servers=("app1" "app2" "app3")

echo "=========multi server ssh ========"

for server in "${server[@]"; do
	echo "checking server"
	
	ssh -o batchmode=yes $server << 'EOF'
	echo "hostname: $(hostname)"
	uptime
	df -h /
EOF
	echo "_________________________"
done
