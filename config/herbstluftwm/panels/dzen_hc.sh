#!/usr/bin/env bash
quote() {
	local q="$(printf '%q ' "$@")"
	printf '%s' "${q% }"
}
hc_quoted="$(quote "${herbstclient_command[@]:-herbstclient}")"
draw_tags() {
	for i in "$1"; do
		case ${i:0:1} in
			'#')
				echo -n "^bg($2)^fg($3)"
				;;
			'+')
				echo -n "^bg($4)^fg(#ffffff)"
				;;
			':')
				echo -n "^bg()^fg(#ffffff)"
				;;
			'!')
				echo -n "^bg(#FF0675)^fg(#141414)"
				;;
			*)
				echo -n "^bg()^fg(#ababab)"
				;;
		esac
		# clickable tags if using SVN dzen
		echo -n "^ca(1,$hc_quoted focus_monitor \"$5\" && "
		echo -n "$hc_quoted use \"${i:1}\") ${i:1} ^ca()"
	done
}
