#!/usr/bin/env bash

action=$(printf "configuration.nix\nhome.nix\nWindow manager\n<<<" | rofi -dmenu -i -p "System settings:")

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
