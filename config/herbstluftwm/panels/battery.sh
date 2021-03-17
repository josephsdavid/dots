#!/usr/bin/env bash
bat="$1"
storage="$HOME/usr/tmp/battery"
mkfifo "$storage"
previous_bat="$(cat "$storage")"
bat_stat="$(echo "$bat" | awk '{print $1}')"
if [ "$bat_stat" != "$previous_bat" ]; then
	sleep 2
	notify-send "Battery Status" "$(acpi | sed 's/Battery 0: //gi')"
	echo "$bat_stat" > "$storage"
fi
bat_num=$(echo "$bat" | awk '{print $2}' | sed 's/%//g')

if [ "$(echo "$bat_num < 25" | bc)" -eq 1 ]; then
	batfg="#d70000"
elif [ "$(echo "25 <= $bat_num && $bat_num < 50" | bc)" -eq 1 ]; then
	batfg='#d75f00'
else
	batfg='#008700'
fi

bat_percent=$((bat_num / 10)) #bash does integer division!!

if [ "$bat_stat" != "Discharging" ]; then
	bat_ico='^i(/home/david/Pictures/icons/ac.xbm)'
else
	bat_ico="^i(/home/david/Pictures/icons/bat_"$bat_percent"0.xbm)"
fi

