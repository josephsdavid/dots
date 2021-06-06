#!/usr/bin/env bash

url="$(playerctl -p spotify metadata mpris:artUrl | sed 's/open.spotify.com\/image/i.scdn.co\/image/gi')"
wget -qO- "$url" > ~/.cache/usr/album_art.png
convert ~/.cache/usr/album_art.png -set colorspace Gray -separate -average ~/.cache/usr/album_art.png

#feh --bg-center ~/usr/tmp/album_art.png
