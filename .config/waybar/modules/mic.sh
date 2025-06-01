#!/bin/bash

case "$1" in
    click)
        wpctl set-mute @DEFAULT_SOURCE@ toggle
        ;;
    scroll_up)
        wpctl set-volume @DEFAULT_SOURCE@ .1+
        ;;
    scroll_down)
        wpctl set-volume @DEFAULT_SOURCE@ .1-
        ;;
esac

read -r VOLUME MUTE <<<$(wpctl get-volume "@DEFAULT_SOURCE@" | awk '{ 
    vol = int($2 * 100)
    mute = ($3 == "[MUTED]") ? "yes" : "no"
    print vol, mute
}')

if [ "$MUTE" = "yes" ]; then
    ICON=" "
else
    ICON=""
fi

echo "{\"text\": \"$ICON $VOLUME%\", \"tooltip\": \"Mic volume: $VOLUME%\", \"class\": \"mic\"}"
