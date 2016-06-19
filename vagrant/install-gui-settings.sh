#!/usr/bin/env bash

echo
echo "Personnalisation de l'interface graphique..." >&2

eval `dbus-launch --sh-syntax`

echo "Réglage du fond d'écran de l'utilisateur '$USER'..."

xfconf-query --channel xfce4-desktop \
  --property /backdrop/screen0/monitor0/workspace0/last-image \
  --set /vagrant/vagrant/desktop/rails-wallpaper.jpg
