#!/usr/bin/env bash

echo
echo 'Installation de Git, ZSH, PostgreSQL, NodeJS...' >&2

apt-get upgrade
apt-get dist-upgrade
apt-get install -y language-pack-fr
apt-get install -y git zsh postgresql postgresql-contrib libpq-dev nodejs curl
chsh -s /bin/zsh vagrant
