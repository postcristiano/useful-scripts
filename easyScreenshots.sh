#!/bin/bash

while [ 1 ]; do
    xdotool mousemove $1 $2 click 1 &
    sleep 45
    import -window root ~/medicao_velocidade/image$(date +"%Y_%m_%d_%I_%M_%p").png
done

