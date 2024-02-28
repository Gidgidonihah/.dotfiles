#!/bin/bash

# Install (via brew) packages that require licenses
echo "🥤   Installing licensed packages"

LICENSED_PKGS=(
    "homebrew/cask/bartender"
    "homebrew/cask/choosy"
    "homebrew/cask/dash" # TODO @jweir: needs to be installed with cask
    "homebrew/cask/devutils"
    "homebrew/cask/fantastical"
    "homebrew/cask/paw"
    "homebrew/cask/rocket"
    "homebrew/cask/transmit4"
)


multi_select_from_list "${LICENSED_PKGS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
brew install ${selected_packages[@]}

for PKG in $CASK_PKGS; do
    confirm_to_continue "Have entered your license for and/or logged in to $PKG?"
done

if [[ " ${selected_packages[*]} " =~ " dropbox " ]]; then
    enter_to_continue "Please make sure dropbox is syncing"
    open /Applications/Dropbox.app
    confirm_to_continue "Is Dropbox syncing?"
fi

if [[ " ${selected_packages[*]} " =~ " fantastical " ]]; then
    enter_to_continue "Please add your accounts to Fantastical (private, personal, professional, work, etc.)"
    open /Applications/Fantastical\ 2.app
    confirm_to_continue "Is Fantastical syncing?"
fi
