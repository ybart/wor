#!/usr/bin/env bash
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

echo 'Installing RVM...'

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s $1
