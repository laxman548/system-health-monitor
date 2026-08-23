get_memory_usage() {

    MEM_TOTAL=$(grep '^MemTotal:' /proc/meminfo | awk '{print $2}')

    MEM_AVAILABLE=$(grep '^MemAvailable:' /proc/meminfo | awk '{print $2}')

    USED_MEM=$((MEM_TOTAL - MEM_AVAILABLE))

    if [ "$MEM_TOTAL" -eq 0 ]; then
        echo "ERROR: Unable to calculate memory usage." >&2
        return 1
    fi

    MEM_USAGE=$(awk "BEGIN {printf \"%.2f\", ($USED_MEM / $MEM_TOTAL) * 100}")

    echo "$MEM_USAGE%"
}
