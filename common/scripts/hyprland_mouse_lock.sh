#!/bin/bash

# set the expected x position of the monitor by your preference
expect_x=1080
# index 0 is the first monitor in your hyprland.conf
curr_x=$(hyprctl -j monitors | jq '.[0].x') 
if [ $curr_x -ne $expect_x ]
then
    hyprctl keyword monitor DP-1, 3840x2160@160.000Hz, ${expect_x}x0, 1
else
    expect_x=$(($expect_x + 10000))
    hyprctl keyword monitor DP-1, 3840x2160@160.000Hz, ${expect_x}x0, 1
fi

hyprctl dispatch focusmonitor DP-2
hyprctl dispatch focusmonitor DP-1
