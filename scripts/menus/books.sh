#!/usr/bin/env bash

dir="$HOME/books"

herbstclient emit_hook bookselector
selection=$(find "$dir" -type f  | awk -F '/' '{print $NF}'| rofi -columns  3 -dmenu -i -p "What would you like to read?")

if [ "$selection" ]; then
	zathura "$dir/$selection"
fi
