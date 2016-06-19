#!/usr/bin/env bash

echo
echo 'Installation de Oh My ZSH...' >&2

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
