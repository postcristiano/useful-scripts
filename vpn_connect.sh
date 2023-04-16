#!/bin/sh
sudo openvpn --config $1 --auth-user-pass $2
#networksetup -setv6off "Wi-Fi"

