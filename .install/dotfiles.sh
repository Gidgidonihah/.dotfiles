#!/bin/bash

# Clone dotfiles repo (with all submodules)
echo "🥤   Cloning dotfiles"

# Note: You may want to use https instead: https://github.com/Gidgidonihah/.dotfiles.git
# git clone --recurse-submodules -j8 git@github.com:Gidgidonihah/.dotfiles.git ~/.dotfiles
# TODO: temmporary for testing
git clone --recurse-submodules -j8 --single-branch -b automation-init git@github.com:Gidgidonihah/.dotfiles.git
mv -f ~/.dotfiles/* ~/.dotfiles/.* ~/
rmdir ~/.dotfiles

cd ~/.vim/bundle/YouCompleteMe
./install.py
cd -
