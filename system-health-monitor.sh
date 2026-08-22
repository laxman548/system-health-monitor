#!/bin/bash

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)


echo "========================================"
echo "         SYSTEM HEALTH MONITOR"
echo "========================================"

echo "Hostname          : $HOSTNAME"
echo "Current User      : $CURRENT_USER"
echo "Operating System  : $OS"
echo "Kernel            : $KERNEL"
echo "Uptime            : $UPTIME"

echo "========================================"
