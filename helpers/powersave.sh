#!/bin/bash

if [ -z $1 ] ; then
  echo "usage powersave.sh (0|1)"
  logger "powersave didn't get arguments"
  exit 1
fi

#turn off screen ##use off or standby
[ $1 -eq 0 ] && {
  logger "powersave.sh: deluminate!"
  DISPLAY=:0.0 xset dpms force off
  /usr/bin/tvservice --off > /dev/null 2>&1
}

#turn on screen
[ $1 -eq 1 ] && {
  logger "powersave.sh: illuminate!"
  DISPLAY=:0.0 xset dpms force on
  #DISPLAY=:0.0 xset -dpms
  #DISPLAY=:0.0 xset s off

  DISPLAY=:0.0 xscreensaver-command -exit > /dev/null 2>&1
  /usr/bin/tvservice --preferred > /dev/null 2>&1
  sudo chvt 3;
  sudo chvt 7;
}
