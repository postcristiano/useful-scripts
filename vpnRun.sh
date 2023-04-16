#!/bin/bash
#
#if [ "$EUID" -ne 0 ] 2> /dev/null > /dev/null
#  then echo "It is need run as a root"
#  exit
#fi


<<COMMENT1
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    alias ls='ls --color=auto'
    echo OS
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    echo Unsupported system.
    exit
    ;;
  'WindowsNT')
    OS='Windows'
    echo Unsupported system.
    exit
    ;;
  'Darwin') 
    OS='Mac'
    exit
    networksetup -setv6automatic "Wi-Fi"
    ;;
  *)
    echo Sorry, unidentified system.
    exit
    ;;
esac

echo bbb



cat /sys/module/ipv6/parameters/disable


echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf




if [ -f /etc/debian_version ]; then
    if [[ $(cat /sys/module/ipv6/parameters/disable) == 0 ]]; then
        #echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
        echo "aaaa"
    else
        echo "bbbb"
    fi
else
    echo "Sorry, support only for Debian-based distributions."
fi




if [[ $(cat /sys/module/ipv6/parameters/disable) == 0 ]]; then
    #echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
    echo "aaaa"
else
    echo "bbbb"

fi


echo -n "Your IP Address from now on will be: "
curl ipinfo.io/ip; echo

COMMENT1