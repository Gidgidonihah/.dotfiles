#!/bin/bash

# Brew Install packages
echo "🥤   Installing homebrew packages"

BREW_PKGS='
awscli
cmake
colordiff
ctags
entr
fpp
fzf
git
git-secrets
gnupg
go
grip
gron
hadolint
helm
hey
hr
httpie
joplin
jq
jsonlint
kubectx
kubernetes-cli
lynx
mas
mycli
node
nodeenv
nvm
pgcli
pinentry-mac
pre-commit
python
pyenv
pv
python-yq
reminders-cli
ripgrep
sops
svgo
terminal-notifier
thefuck
tidy-html5
tldr
tree
vim
watch
wget
yamllint
yarn
zoom
'
for PKG in $BREW_PKGS; do
    echo "🥤   Installing $PKG"
    brew install $PKG
done

# Make typescript available for YCM Completion
npm install -g typescript
