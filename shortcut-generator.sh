#!/bin/bash
#
# https://github.com/postcristiano/useful-scripts
#
# Copyright (c) 2023 postCristiano. Released under the BSD License 2.0

<<COMMENT1
# Check if rummimg as a root
if [ "$EUID" -ne 0 ] 2> /dev/null > /dev/null
  then echo "It is need run as a root"
  exit
fi

# Detect users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo 'This installer needs to be run with "bash", not "sh".'
	exit
fi

# Detect supported OS
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
Supported distributions are Ubuntu, Debian, CentOS, and Fedora."
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

COMMENT1

if [ $# -eq 0 ]; then
  echo ""
  echo "Digite os parametros para obter as informacoes de SNMPv3 do radio Harris Falcon III RF 7800M-MP. "
  echo " "
  echo "Rode o script como super usuario colocando os parametros na seguinte ordem:  "
  echo "shortcut-generatot.sh <usuario> <prot_autent> <senha_autent> <prot_cript> <senha_cript> <end_ip_do_radio> <caminho_mibs> "
  echo " "
  echo "Exemplo de sintaxe: "
  echo "7800mmp-snmp.sh USER001 SHA senha123 AES senha123 10.10.60.50 /home/aluno/Downloads/MIBs/7800M-MP/"
  echo " "
  echo "*atencao nas letras maiusculas e minusculas. "
  echo "**utilize um espaço simples entre os parametros. "
elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
  echo "Rode o script como super usuario colocando os parametros na seguinte ordem:  "
  echo "7800mmp-snmp.sh <usuario> <prot_autent> <senha_autent> <prot_cript> <senha_cript> <end_ip_do_radio> <caminho_mibs> "
  echo " "
  echo "Exemplo de sintaxe: "
  echo "7800mmp-snmp.sh USER001 SHA senha123 AES senha123 10.10.60.50 /home/aluno/Downloads/MIBs/7800M-MP/"
  echo " "
  echo "*atencao nas letras maiusculas e minusculas. "
  echo "**utilize um espaço simples entre os parametros. "
elif [ $# != 3 ]; then
  echo "Sorry you didn't enter the correct amount of parameters for the script."
  exit
else
  rodaprogram
fi





## chmod +x

read -p 'Whats App name: ' appname

sysname="$(tr [A-Z] [a-z] <<< "$appname")"



echo "[Desktop Entry]
Name=$appname       
Keywords=obsidian;markdown;notes;
Exec=/home/cristiano/AppImages/Obsidian.AppImage
Icon=/home/cristiano/AppImages/ico/obsidian.png
Terminal=false
Type=Application
Categories=Utility;" > $sysname.desktop

