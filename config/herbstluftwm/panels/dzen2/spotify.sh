#!/usr/bin/env bash

spotify="$(playerctl -l | grep spotify)"

if [ "$spotify" ]; then
	stat="$(playerctl -p $spotify status)"
	if [ "$stat" != "Paused" ]; then
		ico=""
	else
		ico=""
	fi
	title="$(playerctl -p $spotify metadata title)"
	artist="$(playerctl -p $spotify metadata artist)"
	echo "$ico^fg($1) $title-^fg($2)$artist"
else
	exit
fi


