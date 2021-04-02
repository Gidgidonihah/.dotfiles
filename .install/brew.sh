#!/bin/bash

# Brew Install packages
echo "🥤   Installing homebrew packages"

BREW_TAPS='drone/drone'
for TAP in $BREW_TAPS; do
    brew tap $TAP
done

BREW_PKGS='
awscli
cmake
ctags
colordiff
drone
entr
fpp
fzf
fswatch
git
git-secrets
gnupg
go
hey
hr
httpie
joplin
jq
lynx
mas
mycli
node
nvm
pinentry-mac
python
python-yq
svgo
terminal-notifier
tldr
thefuck
tidy-html5
tree
vim
watchman
wget
yarn
'
for PKG in $BREW_PKGS; do
    echo "🥤   Installing $PKG"
    brew install $PKG
done

# Make typescript available for YCM Completion
npm install -g typescript
