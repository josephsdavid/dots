#!/usr/bin/env bash

update() {
        if [ "$(playerctl -l -s | grep spotify)" ]; then
                storage="$HOME/.cache/usr/song"
                prev="$(cat "$storage")"
                current="$(playerctl -p spotify metadata mpris:artUrl)"

                if [ "$current" != "$prev" ]; then
                        bash ~/bin/get_album_art.sh
                        echo "$current" > "$storage"
                        hsetroot -solid '#323d43' -center ~/.cache/usr/album_art.png
                fi
        else
                prev="$(cat $storage)"
                current="no music"
                if [ "$current" != "$prev" ]; then
                        echo "$current" > "$storage"
                        hsetroot -solid '#323d43'
                fi
        fi
}

while sleep 1;
do update;
done
