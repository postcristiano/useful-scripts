#!/bin/bash

# Set the URL of the website you want to open
URL="https://example.com"

# Set the directory where you want to save the screenshots
DIRECTORY="/path/to/screenshots"

# Open Firefox and navigate to the URL
firefox $URL &

# Refresh the page every 5 minutes (300 seconds)
while true
do
  sleep 300
  xdotool key F5
  
  # Take a screenshot of the page and save it to the specified directory
  FILENAME="$(date +"%Y-%m-%d_%H:%M:%S").png"
  gnome-screenshot -w -f "$DIRECTORY/$FILENAME"
done
