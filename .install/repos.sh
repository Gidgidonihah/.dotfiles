#!/bin/bash
echo "🥤  Cloning personal repos"

ORIG_PATH=$(pwd)

# Clone into ~/Sites
mkdir -p ${HOME}/Sites
cd ~/Sites
for REPO in \
  "https://github.com/IQAndreas/github-issues-import.git" \
  "git@github.com:Gidgidonihah/gidgidonihah.github.com.git" \
  "git@github.com:Gidgidonihah/github-review-slack-notifier.git"
do
  git clone $REPO > /dev/null 2>&1
done

echo "🥤  Cloning Crux repos"

# Clone into ~/Sites/crux
mkdir -p ${HOME}/Sites/crux
cd ${HOME}/Sites/crux

for REPO in \
  "git@github.com:CruxConnect/crux-api.git" \
  "git@github.com:CruxConnect/crux-docker.git" \
  "git@github.com:CruxConnect/crux-docs.git" \
  "git@github.com:CruxConnect/crux-ops-ui.git" \
  "git@github.com:CruxConnect/crux-libs.git" \
  "git@github.com:CruxConnect/crux-crul.git" \
  "git@github.com:CruxConnect/crux-ui.git" \
  "git@github.com:CruxConnect/crux-marketing.git"
do
  git clone $REPO > /dev/null 2>&1
done

# Return to where the script started
cd $ORIG_PATH
