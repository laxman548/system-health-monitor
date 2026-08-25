#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

source ./lib/cpu.sh

source ./lib/memory.sh

source ./lib/disk.sh

source ./lib/process.sh

source ./lib/filesystem.sh

source ./lib/health.sh


HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)


CPU_USAGE=$(get_cpu_usage)
CPU_HEALTH=$(get_health_status "$CPU_USAGE")

MEM_USAGE=$(get_memory_usage)
MEM_USAGE_NUM=${MEM_USAGE%\%}
MEM_HEALTH=$(get_health_status "$MEM_USAGE_NUM")

DISK_USAGE=$(get_disk_usage)
DISK_USAGE_NUM=${DISK_USAGE%\%}
DISK_HEALTH=$(get_health_status "$DISK_USAGE_NUM")

PROCESS_COUNT=$(get_process_count)
TOP_CPU_PROCESS=$(get_top_cpu_process)
TOP_MEMORY_PROCESS=$(get_top_memory_process)

FILESYSTEM_STATUS=$(get_filesystem_status)
FILESYSTEM_HEALTH=$(get_filesystem_health)

OVERALL_HEALTH=$(get_overall_health "$CPU_HEALTH" "$MEM_HEALTH" "$DISK_HEALTH" "$FILESYSTEM_HEALTH")



echo "========================================"
echo "         SYSTEM HEALTH MONITOR"
echo "========================================"

echo "HOSTNAME          : $HOSTNAME"
echo "CURRENT USER      : $CURRENT_USER"
echo "OPERATING SYSTEM  : $OS"
echo "KERNEL            : $KERNEL"
echo "UPTIME            : $UPTIME"

echo "CPU USAGE         : $CPU_USAGE% [$CPU_HEALTH]"
echo "MEMORY USAGE      : $MEM_USAGE [$MEM_HEALTH]"
echo "DISK USAGE        : $DISK_USAGE [$DISK_HEALTH]"
echo "FILESYSTEM HEALTH : $FILESYSTEM_HEALTH"

echo "OVERALL HEALTH    : $OVERALL_HEALTH"

echo "PROCESS COUNT     : $PROCESS_COUNT"
echo "TOP CPU PROCESS   : $TOP_CPU_PROCESS"
echo "TOP MEMORY PROCESS: $TOP_MEMORY_PROCESS"

echo "FILESYSTEM MONITOR"
echo "$FILESYSTEM_STATUS"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "$TIMESTAMP | CPU=$CPU_USAGE% | MEMORY=$MEM_USAGE | DISK=$DISK_USAGE | FILESYSTEM=$FILESYSTEM_HEALTH | OVERALL=$OVERALL_HEALTH" >> logs/system-health.log

echo "========================================"
