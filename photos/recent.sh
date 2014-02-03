#!/bin/bash

#Look for very recent pictures, and display them

DIR=$HOME/ownCloud/Shared/InstantUpload/*
TODAY=$( date +"%Y:%m:%d" )
QUALIFIES=""

for file in $DIR; do
  [[ "$TODAY" == $( exiftool -T -createdate "$file" | cut -d' ' -f1 ) ]] \
    && QUALIFIES=$QUALIFIES" $file"
done

echo "$QUALIFIES"
