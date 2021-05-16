#!/usr/bin/env bash

herbstclient emit_hook wallpaper
dir="$HOME/Pictures/wallpapers"


selection=$(ls "$dir"   | awk -F '/' '{print $NF}'| rofi -dmenu  -columns 3 -i -p "Set a wallpaper!")

feh --bg-fill $dir/$selection
