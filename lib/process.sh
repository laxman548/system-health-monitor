#!/bin/bash

get_process_count() {
	PROCESS_COUNT=$(ps aux | tail -n +2 | wc -l)

	echo "$PROCESS_COUNT"
}

get_top_cpu_process() {

	TOP_CPU_PROCESS=$(ps aux --sort=-%cpu | sed -n '2p' | awk '{print $1, $2, $3, $11}')

	echo "$TOP_CPU_PROCESS"
}

get_top_memory_process() {

    TOP_MEMORY_PROCESS=$(ps aux --sort=-%mem | sed -n '2p' | awk '{print $1, $2, $4, $11}')

    echo "$TOP_MEMORY_PROCESS"
}
