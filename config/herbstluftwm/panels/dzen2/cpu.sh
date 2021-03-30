#!/usr/bin/env bash
cpu_num=$1
if [ "$(echo "$cpu_num < 25" | bc)" -eq 1 ]; then
	cpu_fg='#008700'
elif [ "$(echo "25 <= $cpu_num && $cpu_num < 75" | bc)" -eq 1 ]; then
	cpu_fg='#d75f00'
else
	cpu_fg="#d70000"
fi
