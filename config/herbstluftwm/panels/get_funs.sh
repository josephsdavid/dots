#!/usr/bin/env bash

get_temp() {
	temps="$(sensors | grep °C | grep "temp1\|Composite" | tr "\t" " " | tr "+" " " | tr "°C" " " | awk '{print $2}')"
	divisor="$(echo "$temps" | wc -l)"
	sum="$(echo "$temps" | paste -sd+ - | bc)"

	echo "$sum / $divisor" | bc
}
get_bat() {
	acpi -b | awk '{print $3 $4}' | sed 's/,/ /g'
}

get_ram() {
	free -b | grep Mem | awk '{ printf("%.0f\n",  ($3 * 100 / $2)) }'
}

get_swap() {
	free -b | grep Swap | awk '{ printf("%.0f\n",  ($3 * 100 / $2)) }'
}
get_cpu() {
	iostat -c | head -n 4 | tail -n 1 | awk '{print 100-$6}'
}
