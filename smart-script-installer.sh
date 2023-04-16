#!/bin/bash
#
# https://github.com/postcristiano/useful-scripts
#
# Copyright (c) 2021 postCristiano. Released under the BSD License 2.0

if [ "$EUID" -ne 0 ] 2> /dev/null > /dev/null
    then echo "It is need run as a root"
    exit
fi


if readlink /proc/$$/exe | grep -q "dash"; then
    echo 'This installer needs to be run with "bash", not "sh".'
    exit
fi


if grep -qs "ubuntu" /etc/os-release; then
	  os="ubuntu"
	  os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
	  group_name="nogroup"
elif [[ -e /etc/debian_version ]]; then
	  os="debian"
	  os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
	  group_name="nogroup"
else
	  echo "This installer seems to be running on an unsupported distribution.
Only Debian-base distributions are supported."
	  exit
fi


if [[ "$os" == "ubuntu" && "$os_version" -lt 1804 ]]; then
	  echo "Ubuntu 18.04 or higher is required to use this installer.
This version of Ubuntu is too old and unsupported."
	  exit
fi


if [[ "$os" == "debian" && "$os_version" -lt 9 ]]; then
	  echo "Debian 9 or higher is required to use this installer.
This version of Debian is too old and unsupported."
	  exit
fi


function core() {
    read -p 'Pass name of your application ?: ' appname
    sysappname=$(echo "$input" | tr '[:space:]' '_' | tr '[:upper:]' '[:lower:]')
    echo "Your application runs on CLI or GUI:"
    echo "[1] Command Line Interface (CLI)"
    echo "[2] Graphical User Interface (GUI)"

    read -p "Enter option number: " opt

    case $opt in
        1)
            apptype="true"
            ;;
        2)
            apptype="false"
            ;;
        *)
            echo "Invalid option selected"
            exit 1
            ;;
    esac

    mkdir /opt/$sysappname; mkdir /opt/$sysappname/ico
	cp $1 /opt/$sysappname; cp $2 /opt/$sysappname/ico

	chmod +x /opt/$sysappname

	echo "[Desktop Entry]
Name=$appname       
Keywords=others;$appname;
Exec=/opt/$sysappname/*
Icon=/opt/$sysappname/ico/*
Terminal=$apptype
Type=Application
Categories=Utility;" > /usr/share/applications/$sysappname.desktop
}


if [ $# -eq 0 ]; then
    clear
    echo "It is necessary set the application and its icon.

EXAMPLE
./smart-script-installer.sh ~/Downloads/myAppScript.py ~/Downloads/image.png"
elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
    echo "Smart Script Installer version 0.1 by postCristiano.

./smart-script-installer.sh [<Shell script>|<Python script>|<Perl script>|<Portable binary>|<Linked binary>] [<PNG icon>|<SVG icon>]

EXAMPLES
./smart-script-installer.sh ~/Downloads/myAppScript.py ~/Downloads/image.png
./smart-script-installer.sh ~/Downloads/myApp.AppImage ~/Downloads/image.png
"
else
    if [ $# != 2  ]; then
	    echo "Sorry you didn't enter the correct amount of parameters for the script."
	    exit
		fi
    core
fi

<<ROADMAP
    add unistall feature
    support more OS
ROADMAP