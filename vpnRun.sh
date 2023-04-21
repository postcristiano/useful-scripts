#!/usr/bin/env sh
#
# https://github.com/postcristiano/useful-scripts
#
# Copyright (c) 2023 postCristiano. Released under the BSD License 2.0


if [ "$EUID" -ne 0 ] 2> /dev/null > /dev/null
    then echo "Run as a root"
    exit
fi


OS="`uname`"
case $OS in
    'Linux')
      OS='Linux'
      if [ -f /etc/debian_version ]; then
          if [[ $(cat /sys/module/ipv6/parameters/disable) == 0 ]]; then
              echo 'net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.tun0.disable_ipv6 = 1' >> /etc/sysctl.conf
          /etc/init.d/networking restart
          fi
      else
          echo "Sorry, support only for Debian-based distributions."
          exit
      fi
      ;;
    'FreeBSD')
      OS='FreeBSD'
      echo "Unsupported system."
      exit
      ;;
    'WindowsNT')
      OS='Windows'
      echo "Unsupported system."
      exit
      ;;
    'Darwin') 
      OS='Mac'
      exit
      networksetup -setv6automatic "Wi-Fi"
      ;;
    *)
      echo "Sorry, unidentified system."
      exit
      ;;
esac


if [ "$OS" = "Linux" ] 2> /dev/null > /dev/null
    if ! dpkg-query -W -f='${Status}' "openvpn" 2>/dev/null | grep -q "ok installed"; then
        echo "It is necessary to have OpenVPN installed. Run the install and try later."
        exit
    fi
elif [ $OS = "Mac" ] 2> /dev/null > /dev/null
    if ! brew list -1 | grep -q "^openvpn\$"; then
        echo "It is necessary to have OpenVPN installed. Run the install and try later."
        exit
    fi
else
    echo "Unsupported system."
fi


openvpn --config $1 --auth-user-pass $2 2> /dev/null > /dev/null
sleep 2
echo -n "Your IP Address from now on will be: "
curl ipinfo.io/ip; echo

