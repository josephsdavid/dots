#!/usr/bin/env bash
temp_num="$1"
if [ "$(echo "$temp_num < 70" | bc)" -eq 1 ]; then
	temp_fg='#008700'
elif [ "$(echo "70 <= $temp_num && $temp_num < 90" | bc)" -eq 1 ]; then
	temp_fg='#d75f00'
else
	temp_fg="#d70000"
fi

