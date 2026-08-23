#!/bin/bash

get_disk_usage() {

	DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}')

	echo "$DISK_USAGE"
}
