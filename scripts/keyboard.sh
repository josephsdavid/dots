#!/usr/bin/env bash

[ ! -p /tmp/keeb ] && mkfifo /tmp/keeb

enablek()
{
    xinput set-prop "TPPS/2 Elan TrackPoint" "Device Enabled" 1
    xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 1
    PLUG=1
    [ -p /tmp/keeb ] && echo > /tmp/keeb2 && echo > /tmp/keeb
}

disablek(){
    xinput set-prop "TPPS/2 Elan TrackPoint" "Device Enabled" 0
    xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 0
    PLUG=0
    [ -p /tmp/keeb ] && echo > /tmp/keeb2 && echo > /tmp/keeb
}

poll(){
    OLKB=$(xinput list | grep OLKB)
}

[ "$1" = "e" ] && enablek && exit
[ "$1" = "d" ] && disablek && exit


while true;
do
    poll
    [ "$PLUG" != "1" ] && [ -z "$OLKB" ] && enablek && echo keyboard enabled
    [ "$PLUG" = "1" ] && [ -n "$OLKB" ] && disablek && echo keyboard disabled
    sleep 1
done
