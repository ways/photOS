#!/bin/bash -e

CONFIGFILE="config.ini"
PASSWORDFILE="${MAINPHOTOSDIR}/install/passwords"

force=0
[[ "$1" == "-f" ]] && force=1

echo "Usage: ${0} [-f]

-f force overwriting crontabs even if they exist.

This will overwrite configs for lots of software, and use sudo to install/uninstall stuff. It is only recommended to do this on a fresh install. Hit enter if OK, or Ctrl + c to stopp me."
read

[[ -e ${CONFIGFILE} ]] || \
  { echo "Unable to locate config file ${CONFIGFILE}. Please run me from main photOS dir.";
    exit 1;
  }

. ${CONFIGFILE}
echo ${USERNAME}
echo $HOMEDIR
echo $MAINPHOTOSDIR
echo $DATADIR

[[ -e $PASSWORDFILE ]] || \
  { echo "No password-file. Please copy ${PASSWORDFILE}.dist to ${PASSWORDFILE} and put your passwords in it.";
    exit 1;
  }

echo "TODO: get username etc and add to configfile"

echo "Looking for passwords in ${PASSWORDFILE}..."
mailaddress=$( grep -i mailto ${PASSWORDFILE} | cut -d' ' -f2 | xargs )
mailhub=$( grep -i ssmtp ${PASSWORDFILE} | cut -d' ' -f2 | xargs )
mailuser=$( grep -i ssmtp ${PASSWORDFILE} | cut -d' ' -f3 | xargs )
mailpass=$( grep -i ssmtp ${PASSWORDFILE} | cut -d' ' -f4 | xargs )
echo "* MAILTO - ${mailaddress}. Mailhub ${mailhub}, user $mailuser, pass $mailpass."

owncloud_host=$( grep -i 'owncloud' ${PASSWORDFILE}  | cut -d' ' -f2 | xargs )
owncloud_user=$( grep -i 'owncloud' ${PASSWORDFILE}  | cut -d' ' -f3 | xargs )
owncloud_pass=$( grep -i 'owncloud' ${PASSWORDFILE}  | cut -d' ' -f4 | xargs )
echo "* ownCloud - ${owncloud_user} ${owncloud_pass} ${owncloud_host}."

echo "Deleting some example files."
sudo rm -rfv $HOME/ocr_pi.png $HOME/python_games

echo "Installing software..."
sudo apt-get update -qq
sudo apt-get install -q unclutter libnotify-bin feh libimage-exiftool-perl screen mosh libocsync-plugin-owncloud fs2ram rsync ssmtp mailutils

echo "Uninstalling software..."
sudo apt-get remove -q --purge scratch

echo "Adding services to LXDE autostart."
sudo cp -fv $HOME/photOS/install/autostart /etc/xdg/lxsession/LXDE/autostart

echo "Copying in default configs."

mkdir -p $HOME/.local/share/data/ownCloud
sudo cp -v $HOME/photOS/install/owncloud.cfg $HOME/.local/share/data/ownCloud/
echo "url=${owncloud_host}
user=${owncloud_user}
pass=${owncloud_pass}
" >> $HOME/.local/share/data/ownCloud/owncloud.cfg

sudo cp -fv $HOME/photOS/install/fs2ram.conf /etc/fs2ram/

echo "Disabling screensaver."
sudo cp -fv $HOME/photOS/install/lightdm.conf /etc/lightdm/

echo "Setting up autologin IF we've got lightdm"
# set up lightdm autologin
sudo sed -i 's/^#autologin-user=.*/autologin-user=${USERNAME}/' /etc/lightdm/lightdm.conf
sudo sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf

# set MATE as default session, otherwise login will fail
#sudo sed -i 's/^#user-session=.*/user-session=mate/' /etc/lightdm/lightdm.conf

echo "Setting up mail."
sudo cp -fv $HOME/photOS/install/ssmtp.conf /etc/ssmtp/
echo "root=${mailaddress}
mailhub=${mailhub}
AuthUser=${mailuser}
AuthPass=${mailpass}
" | sudo tee -a /etc/ssmtp/ssmtp.conf > /dev/null

echo "Copying in crontabs if the user doesn't have one already."
[[ 1 -eq ${force} || 0 -eq $( crontab -l > /dev/null ) ]] && {
  echo "* User pi didn't have one, or was forced."
  crontab -r
  echo "MAILTO=${mailaddress}" | cat - $HOME/photOS/install/crontab-pi > /tmp/crontab-pi
  crontab /tmp/crontab-pi
  #rm -f /tmp/crontab-pi;
}
[[ 1 -eq ${force} || 0 -eq $( sudo crontab -l > /dev/null ) ]] && {
  echo "* User root didn't have one, or was forced."
  sudo crontab -r
  echo "MAILTO=${mailaddress}" | cat - $HOME/photOS/install/crontab-root > /tmp/crontab-root
  sudo crontab /tmp/crontab-root
  #rm -f /tmp/crontab-root;
  }

echo "Done!

#TODO
#install pyOwnCloud
"
