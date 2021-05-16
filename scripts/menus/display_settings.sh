#!/usr/bin/env bash

dir=/home/david/.screenlayout/

hc emit_hook monitorconfig
output=$(find "$dir" -type f | awk -F "/" '{print $(NF)}' | rofi -columns 3 -dmenu -i -p "select a screen layout")

if [ "$output" ]; then
	bash "$dir$output"
	herbstclient reload
fi


