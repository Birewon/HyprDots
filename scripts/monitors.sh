#!/bin/bash

STATE="main" 

while true; do
    if hyprctl monitors all | grep -q "HDMI-A-1" && [[ $STATE == "main" ]]; then
        touch /tmp/hdmi_active
        hyprctl keyword monitor "HDMI-A-1, enable" > /dev/null
        hyprctl keyword monitor "HDMI-A-1, 1920x1080@100, auto, 1" > /dev/null
        hyprctl keyword monitor "eDP-1, disable" > /dev/null
        STATE="external"
    elif ! hyprctl monitors | grep -q "HDMI-A-1" && [[ $STATE == "external" ]]; then
        rm -f /tmp/hdmi_active
        STATUS=$(cat /sys/class/power_supply/ACAD/online)
        if [[ $STATUS == 1 ]]; then
            hyprctl keyword monitor "eDP-1, 2560x1600@60, 0x0, 2" > /dev/null
        else
            hyprctl keyword monitor "eDP-1, 1920x1200@60, 0x0, 1.5 > /dev/null"
        fi

        hyprctl keyword monitor "HDMI-A-1, disable" > /dev/null
        STATE="main"
    fi
    sleep 2
done 
    