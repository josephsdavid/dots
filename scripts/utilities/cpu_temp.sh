#!/usr/bin/env bash

temps="$(sensors | grep °C|grep "temp1\|Composite" | tr "\t" " " | tr "+" " " | tr "°C" " " | awk '{print $2}')"
divisor="$(echo "$temps" | wc -l)"
sum="$(echo "$temps" | paste -sd+ - | bc)"

echo "$sum / $divisor" | bc


