get_cpu_usage() {

    CPU1=$(cat /proc/stat | grep '^cpu ' | awk '{print $2, $3, $4, $5, $6, $7, $8}')

    sleep 2

    CPU2=$(cat /proc/stat | grep '^cpu ' | awk '{print $2, $3, $4, $5, $6, $7, $8}')

    CPU1_VALUES=($CPU1)
    CPU2_VALUES=($CPU2)

    USER1=${CPU1_VALUES[0]}
    SYSTEM1=${CPU1_VALUES[2]}
    IDLE1=${CPU1_VALUES[3]}
    IOWAIT1=${CPU1_VALUES[4]}

    USER2=${CPU2_VALUES[0]}
    SYSTEM2=${CPU2_VALUES[2]}
    IDLE2=${CPU2_VALUES[3]}
    IOWAIT2=${CPU2_VALUES[4]}

    USER_DIFF=$((USER2 - USER1))
    SYSTEM_DIFF=$((SYSTEM2 - SYSTEM1))
    IDLE_DIFF=$((IDLE2 - IDLE1))
    IOWAIT_DIFF=$((IOWAIT2 - IOWAIT1))

    BUSY_DIFF=$((USER_DIFF + SYSTEM_DIFF))

    TOTAL_DIFF=$((USER_DIFF + SYSTEM_DIFF + IDLE_DIFF + IOWAIT_DIFF))

    if [ "$TOTAL_DIFF" -eq 0 ]; then
        echo "ERROR: Unable to calculate CPU usage." >&2
        return 1
    fi

    CPU_USAGE=$(awk "BEGIN {printf \"%.2f\", ($BUSY_DIFF / $TOTAL_DIFF) * 100}")

    echo "$CPU_USAGE"
}
