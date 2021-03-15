#!/usr/bin/env bash
ram_num=$1
if [ "$(echo "$ram_num < 25" | bc)" -eq 1 ]; then
	ram_fg='#008700'
elif [ "$(echo "25 <= $ram_num && $ram_num < 75" | bc)" -eq 1 ]; then
	ram_fg='#d75f00'
else
	ram_fg="#d70000"
fi
