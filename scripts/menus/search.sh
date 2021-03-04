#!/usr/bin/env bash

x=$(nix search | ansifilter | grep "\*"  |rofi -dmenu -i -p "Search NixOS Packages:" | awk '{print $2}' | cut -d "." -f2-)
prompt=$(nix search "$x" | ansifilter)

echo "$x" | xclip -i -selection clipboard
output=$(printf "search\nnix-shell\nhome-manager\nshell.nix\nnix-env\nreload-cache\n<<<" | rofi -dmenu -i -p "$prompt:")
case "$output" in
	nix-shell)
		echo "nix-shell -p $x" | xclip -i -selection clipboard
		"${TERMINAL:-termite}" --title "use the clipboard to run nix-shell -p $x"
		;;
	home-manager)
		"${TERMINAL:-termite}" -e "home-manager edit" -t "$x is in your clipboard"
		;;
	nix-env)
		echo "nix-env -iA nixpkgs.$x" | xclip -i -selection clipboard
		"${TERMINAL:-termite}" -t "use the clipboard to run nix-env -iA nixpkgs.$x"
		;;
	reload-cache)
		nix-search -u
		"$HOME/scripts/menus/search.sh"
		;;
	shell.nix)
		"${TERMINAL:-termite}" -e "ranger" -t "$x is in your clipboard"
		;;
	search)
		"$HOME/scripts/menus/search.sh"
		;;
	"<<<")
		"$HOME/scripts/menus/system-menu.sh"
		;;

	esac
