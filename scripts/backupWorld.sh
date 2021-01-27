#!/bin/sh

# Parameter 1, back-up frequency: Minutely, Daily, Weekly, Monthly
# Patameter 2, server folder (opt): junimohut
# Parameter 3, world name (opt): world

if [ "$#" -lt 1 ]; then
  printf 'Script was called without a frequency argument!\n' >&2
  exit 1
fi

SERVER_NAME="junimohut"
if [ "$#" -gt 1 ]; then
  SERVER_NAME="$2"
fi

WORLD_NAME="world"
if [ "$#" -gt 2 ]; then
  WORLD_NAME="$3"
fi

# Grab information from file in /var/


# check current world size versus previous back-up

# If parameter 1 is Daily, Weekly or Monthly, call other shell scripts to handle additional work


# Else if diff >= 2000 KB, save a new backup and push to Github
  # also save the new size to /var/



cd /srv/minecraft/

FILE_NAME=backup-$(date +"%d-%m-%Y--%H:%M")
mkdir -p "/back-ups/$2/$3/$FILE_NAME"

cp -r "/$2/$3" "/back-ups/$2/$3/$FILE_NAME"



git add .
git commit -m "Automated $1 Backup of $2 $3: $FILE_NAME"
git push
