#!/bin/bash

if [[ ! -z "$@" ]];
then
    hyprctl dispatch focuswindow pid:$@
fi

nl='\n'
outputWindows=()
while read line; do

    if [[ -z "$line" ]];
    then
        outputWindows+=("$window")
        window=""
    fi

    window="${line}"$'\n'"${window}"

done < <(hyprctl clients)

echo "Collected lines:"
for line in "${outputWindows[@]}"; do
    #echo $line
    title=$(echo "$line" | grep -Po "title: .*" | sed "s/title: //")
    pid=$(echo "$line" | grep -Po "pid: [0-9]*" | cut -d" " -f2)

    echo "${pid} | ${title}"
done
