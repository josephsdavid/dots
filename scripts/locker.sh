#! /usr/bin/env nix-shell
#! nix-shell -i bash -p betterlockscreen dmenu rofi i3lock
output=$(printf "lock\nhibernate\nreboot\nsuspend\nshutdown\n" | rofi -dmenu)

case "$output" in
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
esac
