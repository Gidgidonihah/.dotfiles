#!/bin/bash

if [ -d /tmp/.install ] || [ -d ~/.install ]; then
  echo "It appears the installation has already been run. This installation script is not idempotent"
  exit 1
fi

# Rather than rely upon input to install Xcode CLI Tools or maintaining my own code,
# just use homebrew's implementation. We do that right away anyway.
# Install Homebrew
echo "Installing HomeBrew (and Xcode CLI tools)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Adjust the the path to include brew, regardless of silicon (install location)
source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/Gidgidonihah/.dotfiles/master/.profile.d/brew.sh)";

# Sparse clone of install scripts to /tmp
# See https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934
cd /tmp
git clone \
  --depth 1  \
  --filter=blob:none  \
  --sparse \
  https://github.com/Gidgidonihah/.dotfiles.git \
;
cd .dotfiles
git sparse-checkout set .install

cd .install

./main.sh
