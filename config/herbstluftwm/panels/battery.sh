#!/usr/bin/env bash
bat="$1"

bat_stat="$(echo $bat | awk '{print $1}')"
bat_num=$(echo "$bat" | awk '{print $2}' | sed 's/%//g')

if [ "$(echo "$bat_num < 25" | bc)" -eq 1 ]; then
	batfg="#d70000"
elif [ "$(echo "25 <= $bat_num && $bat_num < 50" | bc)" -eq 1 ]; then
	batfg='#d75f00'
else
	batfg='#008700'
fi

bat_percent=$((bat_num / 10)) #bash does integer division!!

if [ "$(echo $bat | awk '{print $1}')" != "Discharging" ]; then
	bat_ico='^i(/home/david/Pictures/icons/ac.xbm)'
else
	bat_ico="^i(/home/david/Pictures/icons/bat_"$bat_percent"0.xbm)"
fi

