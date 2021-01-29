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

current_world_size=`du -s /srv/minecraft/junimohut/world | cut -f1`

# Grab the last backup size from the variable file
last_backup_size=0
statefile="/var/minecraft/junimoStateFile"
if [ -f "$statefile" ]; then
  read -r last_backup_size <"$statefile"
fi

# Check if enough has changed on the server to change
if [ "$current_world_size" -ge $((last_backup_size + 2000)) ]; then

  # Save new backup size to variable file
  printf '%d\n' "$current_world_size" >"$statefile"

  # Move to the minecraft directory
  cd /srv/minecraft/

  FILE_NAME=backup-$(date +"%d-%m-%Y--%H:%M")
  mkdir -p "/back-ups/$2/$3/$FILE_NAME"

  # Copy current world folder into backup file structure
  cp -r "/$2/$3" "/back-ups/$2/$3/$FILE_NAME"

  # Git to savin' already!
  git add .
  git commit -m "Automated $1 Backup of $2 $3: $FILE_NAME"
  git push
fi

# If parameter 1 is Daily, Weekly or Monthly, call other shell scripts to handle additional...
