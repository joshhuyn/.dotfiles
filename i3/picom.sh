#!/bin/sh

killall picom

while pgrep -x picom >/dev/null; do sleep 1; done

picom -b
