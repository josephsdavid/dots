#!/usr/bin/env bash
. /home/david/.config/herbstluftwm/panels/dzen2/colors.sh
bat="$1"
storage="$HOME/.cache/usr/battery"
previous_bat="$(cat "$storage")"
bat_stat="$(echo "$bat" | awk '{print $1}')"
if [ "$bat_stat" != "$previous_bat" ]; then
	if [ "$bat_stat" == "Discharging" ]; then
		paplay /usr/share/sounds/freedesktop/stereo/power-unplug.oga
	else
		paplay /usr/share/sounds/freedesktop/stereo/power-plug.oga
	fi
#	sleep 2
#	notify-send "Battery Status" "$(acpi | sed 's/Battery 0: //gi')"
	echo "$bat_stat" > "$storage"

fi
bat_num=$(echo "$bat" | awk '{print $2}' | sed 's/%//g')

if [ "$(echo "$bat_num < 25" | bc)" -eq 1 ]; then
	batfg=""
elif [ "$(echo "25 <= $bat_num && $bat_num < 60" | bc)" -eq 1 ]; then
	batfg="$yellow"
else
	batfg="$green"
fi
batfg="#b2b2b2"

bat_percent=$((bat_num / 10)) #bash does integer division!!

if [ "$bat_stat" != "Discharging" ]; then
        bat_ico=$(cat ~/Pictures/icons/cbat_"$bat_percent"0.txt)
else
        bat_ico=$(cat ~/Pictures/icons/bat_"$bat_percent"0.txt)
fi

