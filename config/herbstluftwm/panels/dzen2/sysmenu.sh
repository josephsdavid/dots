#!/usr/bin/env bash
. "$HOME/.config/herbstluftwm/panels/dzen2/colors.sh"
get_bat() {
	acpi -b | awk '{print $3 $4}' | sed 's/,/ /g'
}

music_status() {
        status="$(playerctl status spotify)"
        if [ "$status" == "No players found" ]; then
                echo ""
        else
                echo "$status"
        fi
}

handle_music() {


}


if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
	# mawk needs "-W interactive" to line-buffer stdout correctly
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
	uniq_linebuffered() {
		awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
	}
else
	# other awk versions (e.g. gawk) issue a warning with "-W interactive", so
	# we don't want to use it there.
	uniq_linebuffered() {
		awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
	}
fi

{
        while true; do
		date +$'date\t^fg()%H:%M:%S^fg(#b2b2b2) %m-^fg()%d'
                get_bat
                sleep 0.5 || break
        done > >(uniq_linebuffered) &
        childpid=$!
        kill $childpid
} 2>/dev/null | {
        date=""
        battery=""
        spotify_status=""
        # line 116 of dzenpanel
}
