#!/usr/bin/env sh

# Set path to your code
MY_PATH="<path to your code>"

# Download the code from the repository if it is more up-to-date
cd "$MY_PATH"
git pull 

CHANGES_EXIST="$(git status — porcelain | wc -l)"

if [ "$CHANGES_EXIST" -eq 0 ]; then 
    exit 0
fi 

# Upload the local code
git add .; git commit -q -m "$(date +"%Y-%m-%d %H:%M:%S")"; git push -q
