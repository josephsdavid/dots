#!/usr/bin/env bash


herbstclient emit_hook system_menu
action=$(printf "Sign out\nDo not disturb\nTake a screenshot\nInstall packages\nSystem settings\nReload\nMonitor configuration\nDisplay power saver\nAudio settings\nBluetooth settings\nRead a book\nSet the wallpaper" | rofi -dmenu -columns 2 -i -p "System Actions:")



case "$action" in
	"Sign out")
		"$HOME/scripts/menus/locker.sh"
		;;
	"Do not disturb")
		if [ "$(dunstctl is-paused)" == "false" ]; then
			notify-send "Pausing notifications..."
			sleep 2
			dunstctl set-paused true
		else
			dunstctl set-paused false
			notify-send "Notifications enabled"
		fi
		;;
	"Monitor configuration")
		"$HOME/scripts/menus/display_settings.sh"
		;;
	"Take a screenshot")
		"$HOME/scripts/utilities/screenshot"
		;;
	"Install packages")
		"$HOME/scripts/menus/search.sh"
		;;
	"System settings")
		"$HOME/scripts/menus/system-settings"
		;;
	"Reload")
		"$HOME/scripts/menus/reload.sh"
		;;
	"Display power saver")
		save=$(printf "disable\nenable\n<<<" | rofi -dmenu -i -p "Display power-saver")
		case "$save" in
			disable)
				notify-send "Screen power saving disabled"
				xset s off -dpms
				;;
			enable)
				notify-send "Screen power saving enabled"
				xset s on +dpms
				;;
			"<<<")
				"$HOME/scripts/menus/system-menu.sh"
				;;
		esac
		;;
	"Bluetooth settings")
		herbstclient spawn blueberry
		;;
	"Audio settings")
		herbstclient spawn termite -e pulsemixer
		;;
	"Read a book")
		"$HOME/scripts/menus/books.sh"
		;;
	"Set the wallpaper")
		"$HOME/scripts/menus/wallpaper.sh"
		;;

esac

