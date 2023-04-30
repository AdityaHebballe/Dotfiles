#!/bin/bash
#Usage: ./brightness.sh [brightness-up / brightness-down / brightness-mute] [int]
#Usage: ./brightness.sh [temperature-up / temperature-down / temperature-mute] [int]

dir=`dirname "$0"`
icon_folder="~/.config/hypr/icons"
amount=$2
id_brightness="8054"
id_temperature="8055"
value_brightness=`ddcutil getvcp 10 |awk -F"[, \t]*" '{print $9}'`
value_temperature=`timeout 0.01 ddcutil getvcp &`

# Functions
function notification_bar {
    dunstify -u low -r "$id" -h int:value:"$value" "${text}" -a "${header}" -i "${icon}"
}

case $1 in
# Brightness
brightness-up)
    value=$value_brightness
    header="Brightness"
    text="Currently at ${value}%"
    icon="$icon_folder/brightness-up.png"
    id=$id_brightness
	ddcutil --bus 2 setvcp --sleep-multiplier .1 10 + ${amount}
	notification_bar;;

brightness-down)
    value=$value_brightness
    header="Brightness"
    text="Currently at ${value}%"
    icon="$icon_folder/brightness-down.png"
    id=$id_brightness
	ddcutil --bus 2 setvcp --sleep-multiplier .1 10 - ${amount}
	notification_bar;;
esac
