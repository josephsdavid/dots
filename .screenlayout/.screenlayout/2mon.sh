#!/bin/sh
xrandr --output eDP --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off
herbstclient reload
