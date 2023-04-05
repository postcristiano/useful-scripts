#!/bin/sh

### Script to control suspend feature on gnome

if [[ $1 == 'off' ]]; then
  echo "turning off suspend"
  gsettings set org.gnome.desktop.session idle-delay 0
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
else
  echo "turning on suspend"
  gsettings set org.gnome.desktop.session idle-delay 900
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'

fi
