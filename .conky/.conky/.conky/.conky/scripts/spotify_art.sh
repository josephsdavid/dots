#!/usr/bin/env bash

update() {
        if [ "$(playerctl -l | grep spotify)" ]; then
                storage="$HOME/.cache/usr/song"
                prev="$(cat "$storage")"
                current="$(playerctl -p spotify metadata mpris:artUrl)"

                if [ "$current" != "$prev" ]; then
                        bash ~/bin/get_album_art.sh
                        echo "$current" > "$storage"
                fi
        else
                echo "no music playing duderino!" > "$storage"
        fi
}

spotify="$(playerctl -l | grep spotify)"

if [ "$spotify" ]; then
        update
else
        cp ~/Pictures/wallpapers/pizza.jpg ~/.cache/usr/album_art.png
fi
