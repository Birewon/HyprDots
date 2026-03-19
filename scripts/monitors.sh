#!/bin/bash

STATE="main" 

while true; do
    sleep 2
    if hyprctl monitors | grep -q "HDMI-A-1" && [[ $STATE == "main" ]]; then
        hyprctl keyword monitor "eDP-1, disable" > /dev/null
        hyprctl keyword monitor "HDMI-A-1, enable"
        STATE="external"
    elif ! hyprctl monitors | grep -q "HDMI-A-1" && [[ $STATE == "external" ]]; then
        hyprctl keyword monitor "eDP-1, highrr, auto, 2" > /dev/null
        hyprctl keyword monitor "HDMI-A-1, disable"
        STATE="main"
    fi
done 
    