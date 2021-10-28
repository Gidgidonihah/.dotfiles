#!/bin/bash

# Clone dotfiles repo (with all submodules)
echo "🥤   Cloning dotfiles"

# TODO: prompt for git vs http. Take param that defaults all prompts with a default
# Note: You may want to use https instead: https://github.com/Gidgidonihah/.dotfiles.git
git clone --recurse-submodules -j8 git@github.com:Gidgidonihah/.dotfiles.git ~/.dotfiles
mv -f ~/.dotfiles/* ~/.dotfiles/.* ~/
rmdir ~/.dotfiles

cd ~/.vim/pack/git-plugins/start/YouCompleteMe
./install.py
cd -
