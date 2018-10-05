#!/bin/bash

# Clone dotfiles repo (with all submodules)
echo "Cloning dotfiles"

git clone --recurse-submodules -j8 https://github.com/Gidgidonihah/.dotfiles.git ~/.dotfiles
mv ~/.dotfiles/* ~/.dotfiles/.* ~/
rmdir ~/.dotfiles
# git submodule update --init --recursive --remote
# TODO: vim-repeat and vim-import-js fail the submodule update
# TODO: Why is everything dirty after submodule init?

cd ~/.vim/bundle/YouCompleteMe
./install.py
cd -
