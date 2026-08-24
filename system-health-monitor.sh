#!/bin/bash

set -euo pipefail

source ./lib/cpu.sh

source ./lib/memory.sh

source ./lib/disk.sh

source ./lib/process.sh

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)

CPU_USAGE=$(get_cpu_usage)
MEM_USAGE=$(get_memory_usage)
DISK_USAGE=$(get_disk_usage)
PROCESS_COUNT=$(get_process_count)
TOP_CPU_PROCESS=$(get_top_cpu_process)
TOP_MEMORY_PROCESS=$(get_top_memory_process)


echo "========================================"
echo "         SYSTEM HEALTH MONITOR"
echo "========================================"

echo "Hostname          : $HOSTNAME"
echo "Current User      : $CURRENT_USER"
echo "Operating System  : $OS"
echo "Kernel            : $KERNEL"
echo "Uptime            : $UPTIME"
echo "CPU Usage         : $CPU_USAGE%"
echo "MEMORY USAGE      : $MEM_USAGE"
echo "DISK USAGE        : $DISK_USAGE"
echo "PROCESS COUNT     : $PROCESS_COUNT"
echo "TOP CPU PROCESS   : $TOP_CPU_PROCESS"
echo "TOP MEMORY PROCESS: $TOP_MEMORY_PROCESS"

echo "========================================"
