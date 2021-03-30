#!/usr/bin/env bash

dir="$HOME/Pictures/wallpapers"


selection=$(ls "$dir"   | awk -F '/' '{print $NF}'| rofi -dmenu -i -p "Set a wallpaper!")

feh --bg-fill $dir/$selection
