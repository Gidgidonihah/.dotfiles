#!/bin/bash

# Get our source location
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Source our helpful functions
source "$DIR/functions.sh"

# Brew Install packages
. "$DIR/brew.sh"

# Install Mac App Store Apps
. "$DIR/mas.sh"

# Install Homebrew Casks
. "$DIR/casks.sh"

# Install global NPM packages
. "$DIR/npm.sh"

# Set up SSH
. "$DIR/ssh.sh"

# Clone dotfiles (should be done after public key is added to github)
. "$DIR/dotfiles.sh"

# Clone commonly used repos
. "$DIR/repos.sh"

# Set up GPG
. "$DIR/gpg.sh"

# Configure macOS
. "$DIR/macOS.sh"

# Prompt for manual steps
. "$DIR/misc-steps.sh"

echo "Done. Note that some of these changes require a logout/restart to take effect."
confirm "Would you like to do so now?" \
  && osascript -e 'tell application "loginwindow" to  «event aevtrlgo»' > /dev/null 2>&1
