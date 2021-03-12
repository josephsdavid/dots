#!/usr/bin/env bash

dir=/home/david/.screenlayout/

output=$(find "$dir" -type f | awk -F "/" '{print $(NF)}' | rofi -dmenu -i -p "select a screen layout")

if [ "$output" ]; then
	bash "$dir$output"
	herbstclient reload
fi


