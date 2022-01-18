#!/usr/bin/env bash

term_dir="$HOME/.config/alacritty"

hc() {
	herbstclient "$@"
}

theme=$(hc getenv theme)

if [ "$theme" != "dark" ]; then
	cp "$term_dir/everforest.yml" "$term_dir/alacritty.yml"
	#feh --bg-fill "/home/david/Pictures/wallpapers/bridge.jpg"
	#feh --bg-fill "$HOME/Pictures/hank.jpg"
	hc setenv theme dark
else
	cp "$term_dir/everforest.yml" "$term_dir/alacritty.yml"
#	feh --bg-fill "$HOME/Pictures/hank.jpg"
	#feh --bg-fill "$HOME/Pictures/wallpapers/hank.jpg"
	hc setenv theme light
fi

