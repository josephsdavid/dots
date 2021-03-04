#! /usr/bin/env bash
output=$(printf "logout\nlock\nhibernate\nreboot\nsuspend\nshutdown\n<<<" | rofi -dmenu -i -p "Select an action:")

case "$output" in
	logout)
		herbstclient quit
		;;
	lock)
		betterlockscreen -l dim
		;;
	suspend)
		betterlockscreen -s dim
		;;
	hibernatl)
		systemctl hibernate
		;;
	reboot)
		systemctl reboot
		;;
	shutdown)
		systemctl poweroff
		;;
	"<<<")
		"$HOME/scripts/menus/system-menu.sh"
		;;
esac
