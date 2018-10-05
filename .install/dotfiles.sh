#!/bin/bash

# Clone dotfiles repo (with all submodules)
echo "Cloning dotfiles"

# Note: You may want to use https instead: https://github.com/Gidgidonihah/.dotfiles.git
git clone --recurse-submodules -j8 git@github.com:Gidgidonihah/.dotfiles.git ~/.dotfiles
mv -f ~/.dotfiles/* ~/.dotfiles/.* ~/
rmdir ~/.dotfiles

# git submodule update --init --recursive --remote
# TODO: vim-repeat and vim-import-js fail the submodule update
# TODO: Why is everything dirty after submodule init?

cd ~/.vim/bundle/YouCompleteMe
./install.py
cd -
