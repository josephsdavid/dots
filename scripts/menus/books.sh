#!/usr/bin/env bash

dir="$HOME/books"

selection=$(find "$dir" -type f  | awk -F '/' '{print $NF}'| rofi -dmenu -i -p "What would you like to read?")

if [ "$selection" ]; then
	zathura "$dir/$selection"
fi
