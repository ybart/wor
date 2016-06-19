#!/usr/bin/env bash

echo 'Installing Ruby...'

source $HOME/.rvm/scripts/rvm

rvm use --default --install $1

shift

if (( $# ))
then gem install $@
fi

rvm cleanup all
