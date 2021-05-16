#!/usr/bin/env bash

. "$HOME/.config/herbstluftwm/panels/dzen2/colors.sh"

menudir="$HOME/scripts/menus"
utildir="$HOME/scripts/utilities"

font="Noto Sans Display Nerd Font"
dzen_font="-*-tamsyn-*-*-*-*-12-*-*-*-*-*-*-*"
pad_height="$(herbstclient getenv pad_height)"
xpos=0
ypos="$pad_height"


printf "^fn($font-12)System Menu\n^fn($font-10)Sign out\n^fn($font-10)Do not disturb\n^fn($font-10)Take a screenshot\n^fn($font-10)Install packages\n^fn($font-10)System settings\n^fn($font-10)Reload\n^fn($font-10)Monitor configuration\n^fn($font-10)Display power saver\n^fn($font-10)Audio settings\n^fn($font-10)Bluetooth settings\n^fn($font-10)Read a book\n^fn($font-10)Set the wallpaper" | dzen2 -y "$ypos" -x "$xpos" -l 12 -e 'onstart=uncollapse;button1=menuexec;leaveslave=exit;button3=exit' -p -fn "$dzen_font"  -bg "$normal_bg" -tw 200 -ta l -w 200
