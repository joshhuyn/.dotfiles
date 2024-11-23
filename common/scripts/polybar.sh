#!/bin/sh

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep1; done

if type "xrandr"; then
    xrandr --query | grep " connected" | while read line
    do
        current_monitor=$(echo $line | cut -d" " -f1)

        if [[ $line == *"1920"* && $line == *"1080"* ]]; then
            MONITOR=$current_monitor polybar --reload main &
        else
            MONITOR=$current_monitor polybar --reload fourK &
        fi
    done
else
    polybar &
fi
