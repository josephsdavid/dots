#!/usr/bin/env bash

update() {
        if [ "$(playerctl -l | grep spotify)" ]; then
                storage="$HOME/usr/tmp/song"
                prev="$(cat "$storage")"
                current="$(playerctl -p spotify metadata mpris:artUrl)"

                if [ "$current" != "$prev" ]; then
                        bash ~/bin/get_album_art.sh
                        echo "$current" > "$storage"
                fi
        else
                echo "no music"
        fi
}

while sleep 1;
do update;
done
