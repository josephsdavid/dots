#!/usr/bin/env bash
. /home/david/.config/herbstluftwm/panels/dzen2/colors.sh
temp_num="$1"
if [ "$(echo "$temp_num < 70" | bc)" -eq 1 ]; then
	temp_fg="$blue"
        temp_char=' '
elif [ "$(echo "70 <= $temp_num && $temp_num < 90" | bc)" -eq 1 ]; then
	temp_fg="$orange"
        temp_char=' '
else
	temp_fg="$red"
        temp_char=' '
fi

temp_fg="#b2b2b2"
