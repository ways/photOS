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
}

#turn on screen
[ $1 -eq 1 ] && {
  logger "powersave.sh: illuminate!"
  DISPLAY=:0.0 xset dpms force on
  sleep 1
  sudo chvt 3;
  sleep 1
  sudo chvt 7;
}
