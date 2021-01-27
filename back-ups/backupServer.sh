#!/bin/sh

# Accepts 1 parameter, which is appended to the file name, used to denote the back-up frequency
# Use the following: Minutely, Hourly, Daily, Weekly, Monthly
FILE_NAME=backup-$(date +"%d-%m-%Y--%H:%M")
mkdir "/home/cameronaj/minecraft/back-ups/$1/"
mkdir "/home/cameronaj/minecraft/back-ups/$1/$FILE_NAME"
cp -r /srv/minecraft/junimohut/world "/home/cameronaj/minecraft/back-ups/$1/$FILE_NAME"

# If Minutely, Do nothing
# If Hourly, Do nothing
# If Daily, delete Minutely
# If Weekly, delete Hourly
# If Monthly, delete Daily

cd /home/cameronaj/minecraft/back-ups

if [ $1 = 'Daily' ]
then
  rm -r Minutely/
elif [ $1 = 'Weekly' ]
then
  rm -r Minutely/
  rm -r Hourly/
elif [ $1 = 'Monthly' ]
then
  rm -r Minutely/
  rm -r Hourly/
  rm -r Daily/
  rm -r Weekly/
fi

git add .
git commit -m "Automated $1 Backup (and Pruning) of JunimoHut world: $FILE_NAME"
git push
