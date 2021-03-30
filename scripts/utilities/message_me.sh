#!/usr/bin/env bash
message=$(printf "hey\nnerd" | rofi -dmenu -i -p "text yourself!")

curl -X POST https://textbelt.com/text \
   --data-urlencode phone='2144585261' \
   --data-urlencode message="$message" \
   -d key=textbelt
