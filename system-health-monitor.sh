#!/bin/bash

set -euo pipefail

source ./lib/cpu.sh

source ./lib/memory.sh


HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)

CPU_USAGE=$(get_cpu_usage)
MEM_USAGE=$(get_memory_usage)

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

echo "========================================"
