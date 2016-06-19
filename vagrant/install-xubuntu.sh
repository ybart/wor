#!/usr/bin/env bash

echo 'Installing xubuntu...'

apt-get install -y --no-install-recommends xubuntu-desktop
apt-get install -y xfce4-terminal xfce4-quicklauncher-plugin
apt-get install -y virtualbox-guest-x11 firefox
#VBoxClient-all

add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer

cp /vagrant/vagrant/desktop/rails-wallpaper.jpg /usr/share/xfce4/backdrops/
cp /vagrant/vagrant/desktop/rails-logo.png /home/ubuntu/.face

groupadd -r autologin
gpasswd -a ubuntu autologin
