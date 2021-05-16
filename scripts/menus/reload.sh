#!/usr/bin/env bash

herbstclient emit_hook reload_settings
action=$(printf "configuration.nix\nhome.nix\nWindow manager\n<<<" | rofi -dmenu -columns 3 -i -p "Reload system settings:")

case "$action" in
	"configuration.nix")
		"${TERMINAL:-termite}" -e "sudo nixos-rebuild switch"
		;;
	"home.nix")
		"${TERMINAL:-termite}" -e "home-manager switch"
		;;
	"Window manager")
		herbstclient reload
		;;
	"<<<")
		"$HOME/scripts/menus/system-menu.sh"
		;;

esac

if [ "$action" != "<<<" ]; then
	notify-send "$action was successfully reloaded"
fi
