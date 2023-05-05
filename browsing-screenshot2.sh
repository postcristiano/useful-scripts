#!/bin/bash

URL="https://beta.simet.nic.br/"

DIRECTORY="~/Pictures"

sleep 3
while true
do
    firefox $URL &
    PID=$!
    sleep 60
    FILENAME="$(date +"%Y-%m-%d_%H:%M:%S").png"
    gnome-screenshot -w -f "$DIRECTORY/$FILENAME" 2>/dev/null
    pkill firefox 2>/dev/null
done
