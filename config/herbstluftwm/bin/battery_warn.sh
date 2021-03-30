#!/usr/bin/env bash

while true
do
	bat="acpi -b | grep -P -o '[0-9]+(?=%)'"
	if [ $bat -le 10 ]; then
		notify-send -u critical "LOW BATTERY!"
