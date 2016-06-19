#!/usr/bin/env bash

echo 'Installing Packages...'

apt-get upgrade
apt-get dist-upgrade
apt-get install -y language-pack-fr
apt-get install -y git zsh postgresql postgresql-contrib libpq-dev nodejs
chsh -s /bin/zsh ubuntu

echo '127.0.0.1 xubuntu-xenial' > /etc/hosts
