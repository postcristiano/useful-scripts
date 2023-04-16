#!/bin/sh

if [ "$EUID" -ne 0 ] 2> /dev/null > /dev/null
  then echo "It is need run as a root"
  exit
fi

echo aaaa
