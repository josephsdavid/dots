#!/usr/bin/env bash

spotify="$(playerctl -l | grep spotify)"

if [ "$spotify" ]; then
	stat="$(playerctl -p $spotify status)"
	if [ "$stat" != "Paused" ]; then
		ico="$HOME/Pictures/icons/play.xbm"
	else
		ico="$HOME/Pictures/icons/pause.xbm"
	fi
	title="$(playerctl -p $spotify metadata title| tr -cd '[:alnum:]._ _-')"
	artist="$(playerctl -p $spotify metadata artist| tr -cd '[:alnum:]._ _-')"
	echo "^fg($1)^i($ico) ^fg($1)$title-^fg($2)$artist"
else
	exit
fi


