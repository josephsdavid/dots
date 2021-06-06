#!/usr/bin/env bash
. ~/.config/herbstluftwm/panels/dzen2/colors.sh

spotify_bar(){
spotify="$(playerctl -l | grep spotify)"
if [ "$spotify" ]; then
        stat="$(playerctl -p spotify status)"
	if [ "$stat" != "Paused" ]; then
		ico=""
	else
		ico=""
	fi
        echo "^fn(Noto Sans Display Nerd Font-48)^ca(1, playerctl previous) ^ca()^ca(1, playerctl play-pause)$ico^ca()^ca(1, playerctl next) ^ca()" ;
else
        echo "^fn(Noto Sans Display Nerd Font-44)^ca(1, herbstclient spawn ~/scripts/menus/system-settings)^fg(gray)漣 ^ca()^ca(1, herbstclient spawn spotify)^fg($green) ^ca()^ca(1, herbstclient spawn ~/scripts/utilities/screenshot)^fg($blue)^ca()"
fi
}

{ while true; do
        conky_status="$(herbstclient getenv conky)"
        if [ "$conky_status" != "off" ]; then
                spotify_bar
        else
                echo ""
        fi
        sleep 0.5
done } | dzen2  -h 80 -x 20 -w 210 -y 390 -bg "$normal_bg" -fg "#ffffff" -ta c -e "ungrabkeys; onstart=lower" -title-name "spotify_bar" -p &

