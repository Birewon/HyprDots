#!/bin/bash

LUST_STATUS=false
while true; do
    STATUS=$(cat /sys/class/power_supply/ACAD/online)
    if [[ $STATUS != $LUST_STATUS ]]; then
        if [[ $STATUS == 1 ]]; then
            hyprctl keyword monitor "eDP-1, 2560x1600@60, 0x0, 2"
        else
            hyprctl keyword monitor "eDP-1, 1920x1200@60, 0x0, 1.5"
        fi
            LUST_STATUS=$STATUS
    fi
    sleep 2
done