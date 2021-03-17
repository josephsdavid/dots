#!/usr/bin/env bash

notify-send "Battery Status" "$(acpi | sed 's/Battery 0: //gi')"
