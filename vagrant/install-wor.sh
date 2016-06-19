#!/usr/bin/env bash

echo
echo 'Installation du dépôt WoR...' >&2

git clone https://github.com/women-on-rails/wow-curiosites-1.git
cd wow-curiosites-1
bundle
