#!/usr/bin/env bash
. /home/david/.config/herbstluftwm/panels/dzen2/colors.sh
cpu_num=$1
if [ "$(echo "$cpu_num < 25" | bc)" -eq 1 ]; then
	cpu_fg="$green"
elif [ "$(echo "25 <= $cpu_num && $cpu_num < 75" | bc)" -eq 1 ]; then
	cpu_fg="$yellow"
else
	cpu_fg="$red"
fi
