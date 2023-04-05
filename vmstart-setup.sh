#!/bin/sh

echo "Starting $1"
sudo cpupower frequency-set -g performance

/bin/suspend off

sudo virsh start $1
sleep 45
sudo ddcutil setvcp 60 0x0f ##check on your display and change this !!

echo "dont forget to /bin/suspend on after vm shutdown"