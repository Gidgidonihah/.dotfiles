#!/bin/bash
echo "🥤  Cloning personal repos"

ORIG_PATH=$(pwd)

REPOS=(
  "git@github.com:Gidgidonihah/gidgidonihah.github.com.git"
)

# Clone into ~/Sites
mkdir -p ${HOME}/Sites
cd ~/Sites
for REPO in "${REPOS[@]}"; do
  git clone $REPO > /dev/null 2>&1
done

# Return to where the script started
cd $ORIG_PATH
