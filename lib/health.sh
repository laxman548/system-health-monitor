#!/bin/bash

get_health_status() {

    VALUE=$1

    if awk "BEGIN {if ($VALUE >= 90) exit 0; else exit 1}"; then
        echo "CRITICAL"

    elif awk "BEGIN {if ($VALUE >= 70) exit 0; else exit 1}"; then
        echo "WARNING"

    else
        echo "OK"
    fi
}


get_overall_health() {

    CPU_HEALTH=$1
    MEM_HEALTH=$2
    DISK_HEALTH=$3
    FILESYSTEM_HEALTH=$4

    if [ "$CPU_HEALTH" = "CRITICAL" ] || \
       [ "$MEM_HEALTH" = "CRITICAL" ] || \
       [ "$DISK_HEALTH" = "CRITICAL" ] || \
       [ "$FILESYSTEM_HEALTH" = "CRITICAL" ]; then

        echo "CRITICAL"

    elif [ "$CPU_HEALTH" = "WARNING" ] || \
         [ "$MEM_HEALTH" = "WARNING" ] || \
         [ "$DISK_HEALTH" = "WARNING" ] || \
         [ "$FILESYSTEM_HEALTH" = "WARNING" ]; then

        echo "WARNING"

    else
        echo "OK"
    fi
}
