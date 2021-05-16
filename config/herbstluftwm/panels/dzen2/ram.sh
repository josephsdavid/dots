#!/usr/bin/env bash
. /home/david/.config/herbstluftwm/panels/dzen2/colors.sh
ram_num=$1
if [ "$(echo "$ram_num < 25" | bc)" -eq 1 ]; then
	ram_fg="$green"
elif [ "$(echo "25 <= $ram_num && $ram_num < 75" | bc)" -eq 1 ]; then
	ram_fg="$yellow"
else
	ram_fg="$red"
fi
