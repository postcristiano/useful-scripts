#!/bin/bash
#
# https://github.com/postcristiano/useful-scripts
#
# Copyright (c) 2023 postCristiano. Released under the BSD License 2.0


while [ 1 ]; do
    xdotool mousemove $1 $2 click 1 &
    sleep 45
    import -window root ~/medicao_velocidade/image$(date +"%Y_%m_%d_%I_%M_%p").png
done

