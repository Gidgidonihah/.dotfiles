#!/bin/bash
# Create an SSH key and prompt to add it to github

# Prompt for settings
KEYFILE=$(get_input_with_default "Where would you like to save the key" "~/.ssh/id_rsa")
EMAIL=$(get_input "What email would you like to tie to this key")

# Generate a new key - you will be prompted for a password
ssh-keygen -t rsa -b 4096 -C $EMAIL -f $KEYFILE

# Add that key to the ssh-agent
eval "$(ssh-agent -s)"
ssh-add -K $KEYFILE

# Copy the public key
pbcopy < $KEYFILE.pub
echo "Your public key has been copied to the clipboard. Please add it to github."
open https://github.com/settings/keys

confirm_to_continue "Has your key been added to github?"
