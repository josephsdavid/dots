#!/usr/bin/env bash

term_dir="$HOME/.config/alacritty"

hc() {
	herbstclient "$@"
}

theme=$(hc getenv theme)

if [ "$theme" != "dark" ]; then
	cp "$term_dir/all.yml" "$term_dir/alacritty.yml"
    echo "colors: *doom_dark" >> "$term_dir/alacritty.yml"
	#feh --bg-fill "/home/david/Pictures/wallpapers/bridge.jpg"
	hc setenv theme dark
else
	cp "$term_dir/all.yml" "$term_dir/alacritty.yml"
    echo "colors: *doom_light" >> "$term_dir/alacritty.yml"
	#feh --bg-fill "$HOME/Pictures/wallpapers/frog.jpg"
	hc setenv theme light
fi

