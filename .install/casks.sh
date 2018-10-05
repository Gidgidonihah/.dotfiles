#!/bin/bash
# Brew Install Casks
echo "Installing homebrew casks"

# Tap the cask-versions repo
brew tap homebrew/cask-versions

CASK_PKGS='
adobe-creative-cloud
aerial
bartender
choosy
dash
docker
dropbox
fantastical
firefox
google-chrome
google-chrome-canary
imagealpha
imageoptim
iterm2
macdown
macvim
muzzle
ngrok
paw
rocket
safari-technology-preview
sequel-pro
sip
sketch
transmission
transmit4
'

for PKG in $CASK_PKGS; do
    brew cask install $PKG
done
for PKG in $CASK_PKGS; do
    confirm_to_continue "Have entered your license for and/or logged in to $PKG?"
done

enter_to_continue "Please make sure dropbox is syncing"
open /Applications/Dropbox.app
confirm_to_continue "Is Dropbox syncing?"

enter_to_continue "Please log into google chrome and start syncing your settings"
open /Applications/Google\ Chrome.app
confirm_to_continue "Have you installed all Adobe CC apps?"

enter_to_continue "Please install Adobe Creative Cloud"
open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
confirm_to_continue "Have you installed all Adobe CC apps?"
