#!/usr/bin/env bash

echo
echo 'Installation de Ruby via RVM...' >&2

source $HOME/.rvm/scripts/rvm

rvm use --default --install $1

shift

if (( $# ))
then gem install $@
fi

rvm cleanup all
