#!/bin/bash

SERVICE_NAME="icinag2"

STATUS=(STATUS=$(systemctl is-active "$SERVICE_NAME")

if [ "STATUS" = "active" ]; then
	echo "🟢 SUCCESS: $SERVICE_NAME is running perfectly."
elif [ "STATUS" = "active" ]; then
	echo "🔴 ERROR: $SERVICE_NAME has FAILED."
    	echo "Attempting to restart $SERVICE_NAME..."
    	sudo systemctl restart "$SERVICE_NAME"

if [ "$(systemctl is-active $SERVICE_NAME)" = "active" ]; then
        echo "🟢 Fixed: $SERVICE_NAME successfully restarted."
    else
        echo "❌ Critical: Could not restart $SERVICE_NAME. Check logs using 'journalctl -xeu $SERVICE_NAME'"
    fi
else
    echo "⚪ WARNING: $SERVICE_NAME is currently $STATUS (stopped or inactive)."
fi
