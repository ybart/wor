#!/usr/bin/env bash

echo 'Installing GUI settings...'

eval `dbus-launch --sh-syntax`

echo 'Setting Desktop Picture for '$USER'...'

xfconf-query --channel xfce4-desktop \
  --property /backdrop/screen0/monitor0/workspace0/last-image \
  --set /vagrant/vagrant/desktop/rails-wallpaper.jpg
