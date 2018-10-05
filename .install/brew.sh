#!/bin/bash
# Install Homebrew
echo "Installing HomeBrew (and Xcode CLI tools)"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Brew Install packages
echo "Installing homebrew packages"

BREW_TAPS='drone/drone'
for TAP in $BREW_TAPS; do
    brew tap $TAP
done

BREW_PKGS='
autoenv
awscli
cmake
colordiff
drone
fpp
fzf
fswatch
git
gnupg
hr
httpie
joplin
lynx
mas
mycli
node
pinentry-mac
python
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
    brew install $PKG
done

# Make typescript available for YCM Completion
npm install -g typescript
