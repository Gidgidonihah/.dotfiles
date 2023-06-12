#!/bin/bash

# Set up GPG
echo "🥤   Setting up GPG"
source lib/functions.sh

EMAIL=$(get_input 'Email to use for GPG')
NAME='Jason Weir'

# Generate the key without input
cat > /tmp/gpg-key-script <<EOF
     %echo Generating a new key
     Key-Type: RSA
     Key-Length: 4096
     Name-Real: $NAME
     Name-Email: $EMAIL
     Expire-Date: 0
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF
gpg --batch --gen-key /tmp/gpg-key-script
chmod 700 ~/.gnupg

# Get the key id
KEY=$(gpg -K --keyid-format SHORT | grep -i "sec.*rsa" | sed "s/sec.*\/\([^ ]*\) .*/\1/")

echo "Key ID: $KEY"

# Allow adding additional emails to the key
while $(confirm 'Would you like to add another (work) email?'); do
  NEW_EMAIL=$(get_input 'Email')
  {
    echo adduid
    echo $NAME
    echo $NEW_EMAIL
    echo ''
    echo O
    echo quit
    echo y
  } | gpg --command-fd=0 --status-fd=1 --edit-key $KEY
done

# Cause pinentry-mac UI to appear allowing us to store the passphrase in osx keychain
gpg --encrypt --sign --armor -u $KEY -r $EMAIL /tmp/gpg-key-script

# Copy the public key to the clipboard
gpg --armor --export $KEY | pbcopy

# Open up github for easy entry
echo "Your public key has been copied to the clipboard. Please add it to github."
echo "Be sure to check the box to save the passphrase to your keychain or you will regret it."
open https://github.com/settings/keys

# Set github to sign with gpg
git config --global gpg.program $(which gpg)
git config --global user.signingkey $KEY
git config --global commit.gpgsign true

# clean up left over files
rm -f /tmp/gpg-key-script*
