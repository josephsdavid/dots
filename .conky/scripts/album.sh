#!/usr/bin/env bash
spotify="$(playerctl -l | grep spotify)"

if [ "$spotify" ]; then
        playerctl metadata album -p spotify
else
        echo ""
fi


