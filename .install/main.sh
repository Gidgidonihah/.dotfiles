#!/bin/bash

# TODO-POST
#  * Save all the videos and photos (add to photos app) from messages (use Storage\ Management.app)
#  * backup ~/Music
#  * backup ~/Pictures
#  * backup ~/Sites
#  * backup ~/.
#  * backup ENV
#  * backup things.app stuff
#  * backup transmission downloads
#  * backup installed fonts

# TODO-POST:
#   * Safari: Copy all settings
#     * Verify and differences from `defaults read com.apple.Safari`
#       * show full web address

# TODO-POST See README.md
#   * It is in serious need of update

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

# Create an SSH/GPG keys and prompt to add them to github
. "$DIR/ssh.sh"
. "$DIR/gpg.sh"

# Clone dotfiles (should be done after public key is added to github)
. "$DIR/dotfiles.sh"

# Configure macOS
. "$DIR/macOS.sh"

# Prompt for manual steps
. "$DIR/misc-steps.sh"

echo "Done. Note that some of these changes require a logout/restart to take effect."
confirm "Would you like to do so now?" \
  && osascript -e 'tell application "loginwindow" to  «event aevtrlgo»' > /dev/null 2>&1
