#!/usr/bin/env bash
. ~/.config/herbstluftwm/panels/dzen2/colors.sh


app_bar(){
        echo "^fn(Noto Sans Display Nerd Font-72)^ca(1, herbstclient spawn rofi -show drun)^fg($pink)^ca()"
        echo "^fn(Noto Sans Display Nerd Font-72)^ca(1, herbstclient spawn termite -e vim)^fg($green)^ca()"
        echo "^fn(Noto Sans Display Nerd Font-72)^ca(1, herbstclient spawn firefox)^fg($orange)^ca()"
        echo "^fn(Noto Sans Display Nerd Font-72)^ca(1, herbstclient spawn google-chrome-stable)^fg($blue)^ca()"
        echo "^fn(Noto Sans Display Nerd Font-72)^ca(1, herbstclient spawn Discord)^fg($purple)ﭮ^ca()"
        echo "^fn(Noto Sans Display Nerd Font-72)^ca(1, herbstclient spawn slack)^fg($red)^ca()"
}

                app_bar | dzen2  -bg "#240e28" -fg "#240e28" -ta c -h 100 -x 650 -w 650 -y 900 -m h -l 6 -sa c -p -e "ungrabkeys" -title-name app_bar &

