#!/bin/bash

# Create an SSH key and prompt to add it to github
echo "🥤   Generating SSH key for github"

mkdir -p ~/.ssh

# Prompt for settings
KEYFILE=$(get_input_with_default "Where would you like to save the key" "${HOME}/.ssh/id_rsa")
EMAIL=$(get_input "What email would you like to tie to this key")

# Generate a new key - you will be prompted for a password
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f $KEYFILE

# Add that key to the ssh-agent
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain $KEYFILE
open https://github.com/settings/keys
enter_to_continue "Be sure to log into github before continuing so your clipboard won't be overwritten by 1password"

# Copy the public key
pbcopy < $KEYFILE.pub
echo "Your public key has been copied to the clipboard. Please add it to github."
echo '----------------------------'
cat $KEYFILE.pub
echo '----------------------------'

# Setup the config file
echo "Host *
  AddKeysToAgent yes
  UseKeychain yes" > ~/.ssh/config

confirm_to_continue "Has your key been added to github?"
