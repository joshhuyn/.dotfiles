#!/bin/bash

processName=vimb

tmpdir=/tmp/custom
tmpfile=$tmpdir/zenId

function get_process_id()
{
    process_id=""

    if [[ -f $tmpfile ]];
    then
        process_id=$(cat $tmpfile)
    fi

    if [[ -n "$(echo $process_id)" ]] && [[ -n "$(bspc query -N -n .floating | grep $(echo $process_id))" ]];
    then
        echo "$process_id";
        return 0;
    fi

    bspc query -N -n .floating | while read id; do
        if [[ -n $(bspc query --node "$id" -T | grep "vimb") ]];
        then
            if [ ! -d $tmpdir ];
            then
                mkdir $tmpdir
            fi
            echo "$id" > $tmpfile
            echo "$id"
            return 0
        fi
    done;
}

process_id=$(get_process_id)

if [[ -z $process_id ]];
then
    $processName > /dev/null 2>&1 &

    while [[ -z $process_id ]];
    do
        sleep 0.1
        process_id=$(get_process_id)
    done

    bspc node $process_id -g sticky

    exit
fi

bspc node $process_id -g sticky

hidden="$(bspc query --node $process_id -T | jq .hidden)"
if [[ $hidden = "true" ]];
then
    bspc node $process_id --flag hidden=false
else
    bspc node $process_id --flag hidden=true
fi

bspc node $process_id --focus
