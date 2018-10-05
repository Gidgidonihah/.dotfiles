#!/bin/bash

if [ -d ~/.install ]; then
  echo "${red}It appears the installation has already been run. This installation script is not idempotent${reset}"
  exit 1
fi

# Sparse clone of install scripts to /tmp
cd /tmp
svn export https://github.com/Gidgidonihah/.dotfiles/trunk/.install
cd .install

./init.sh
