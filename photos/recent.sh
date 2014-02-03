#!/bin/bash

#Look for very recent pictures, and print their names.
# Usage: recent.sh yesterday, recent.sh "a week ago"
# Usage: ./photOS/photos/basic.sh $( ./photOS/photos/recent.sh "4 days ago" )
#
# Exiftool gives dates like 2014:01:31 10:56:24, which date won't accept.

. /home/pi/photOS/helpers/include.sh

DIR=${REPOSITORY}/Shared/InstantUpload/*
LIMIT="yesterday"
[[ -z "$1" ]] || LIMIT="$1"
RECENT=$( date +"%s" --date "${LIMIT}" )
[[ 0 -ne $? ]] && { echo "Wrong date format on ${LIMIT}"; exit 1; }
QUALIFIES=""

logger --tag recent.sh \
  "Looking for photos more recent than ${LIMIT} ( "$( date --date "${LIMIT}" )")."

for file in $DIR; do
  [[ ${RECENT} -lt \
    $( date +"%s" --date \
    $( exiftool -T -createdate "$file" | cut -d' ' -f1 | sed 's/\:/\-/g' ) ) ]] \
    && QUALIFIES=$QUALIFIES" $file"
done

logger --tag recent.sh \
  "Found "$( echo ${QUALIFIES} | wc -w )"."

echo "$QUALIFIES"
