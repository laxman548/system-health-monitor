#!/bin/bash

get_filesystem_status() {

    df -h | grep -E '^[A-Z]:' | awk '{print $1, $5, $6}' | while read -r FILESYSTEM USAGE MOUNT
    do
        USAGE_NUMBER=${USAGE%\%}

        if [ "$USAGE_NUMBER" -ge 90 ]; then
            STATUS="CRITICAL"
        elif [ "$USAGE_NUMBER" -ge 80 ]; then
            STATUS="WARNING"
        else
            STATUS="OK"
        fi

        echo "Filesystem: $FILESYSTEM"
        echo "Usage: $USAGE"
        echo "Mount: $MOUNT"
        echo "Status: $STATUS"
        echo "----------------"
    done
}
