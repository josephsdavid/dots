#!/usr/bin/env bash

term_dir="$HOME/.config/termite"

hc() {
	herbstclient "$@"
}

theme=$(hc getenv theme)

if [ "$theme" != "dark" ]; then
	cp "$term_dir/nightconf" "$term_dir/config"
#	feh --bg-fill "$HOME/Pictures/abredblue.jpg"
	feh --bg-fill "$HOME/Pictures/hank.jpg"
	hc setenv theme dark
else
	cp "$term_dir/dayconf" "$term_dir/config"
	feh --bg-fill "$HOME/Pictures/hank.jpg"
	hc setenv theme light
fi

pkill -USR1 termite
