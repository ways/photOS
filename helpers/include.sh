#!/bin/bash

## variables to be included in all scripts
## include this way:
## . /home/pi/photOS/helpers/include.sh

PHOTOS=/home/pi/photOS
PATH=${PATH}:${PHOTOS}/helpers:${PHOTOS}/photos:${PHOTOS}/videos:${PHOTOS}/streams

## photos, and place to import photos
REPOSITORY="${HOME}/ownCloud/"

## must set display for X programs. use this way: `$SETDISPLAY`
SETDISPLAY="export DISPLAY=:0.0 "

##list of images with meta
EXIFDB=${REPOSITORY}/exif.db
