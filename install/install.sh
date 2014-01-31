#!/bin/bash -xe
PASSWORDFILE="$HOME/photOS/install/passwords"

[[ -e $PASSWORDFILE ]] || \
  { echo "No password-file. Please copy ${PASSWORDFILE}.dist to ${PASSWORDFILE} and put your passwords in it.";
    exit 1;
  }

echo "Looking for passwords..."
owncloud=$( grep 'owncloud' $HOME/install/passwords.local

echo "Installing software..."
sudo apt-get install unclutter libnotify-bin feh libimage-exiftool-perl screen mosh libocsync-plugin-owncloud fs2ram rsync ssmtp mailutils

echo "Uninstalling software..."
sudo apt-get remove --purge scratch

echo "Deleting some example files"
sudo rm -rfv /home/pi/ocr_pi.png /home/pi/python_games

echo "Adding services to LXDE autostart"
sudo cp -fv /home/pi/photOS/install/autostart /etc/xdg/lxsession/LXDE/autostart

echo "Copying in default configs, whether you have them or not"
mkdir -p /home/pi/.local/share/data/ownCloud
sudo cp -fv /home/pi/photOS/install/owncloud.cfg /home/pi/.local/share/data/ownCloud/
sudo cp -fv /home/pi/photOS/install/fs2ram.conf /etc/fs2ram/
sudo cp -fv /home/pi/photOS/install/ssmtp.conf /etc/

echo "Copying in crontabs _IF_ the user doesn't have one already"
[[ crontab -l -u pi ]] || sudo crontab -u pi /home/pi/photOS/install/crontab-pi
[[ sudo crontab -l -u root ]] || sudo crontab -u root /home/pi/photOS/install/crontab-root

echo "Disabling screensaver"
awk '/\[SeatDefaults\]/ { print; print "xserver-command=X -s 0 dpms"; next }1' /etc/lightdm/lightdm.conf | sudo tee /etc/lightdm/lightdm.conf > /dev/null

echo "Done!"
echo "Remember to:
* set credentials in /etc/ssmtp.conf
* set credentials in /home/pi/photOS/install/owncloud.cfg
* set a MAILTO address in crontab if you want e-mails to gome somewhere"
