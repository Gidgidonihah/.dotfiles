#!/bin/bash

if [ -d ~/.install ]; then
  echo "${red}It appears the installation has already been run. This installation script is not idempotent${reset}"
  exit 1
fi

# Rather than rely upon input to install Xcode CLI Tools or maintaining my own code,
# just use homebrew's implementation. We do that right away anyway.
# Install Homebrew
echo "Installing HomeBrew (and Xcode CLI tools)"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Sparse clone of install scripts to /tmp
cd /tmp
# TODO: temporarily changed for full testing
svn export https://github.com/Gidgidonihah/.dotfiles/branches/automation-init/.install
# svn export https://github.com/Gidgidonihah/.dotfiles/trunk/.install
cd .install

./init.sh
