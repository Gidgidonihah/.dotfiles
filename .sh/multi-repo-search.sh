#!/usr/bin/env bash

# TODO: hide repos that had no results

CMD=$EDITOR
BASE=~/Sites
while getopts "pb:" OPTION; do
    case $OPTION in
      p) CMD=$PAGER ;;
      b) BASE=$OPTARG ;;
      :) echo "ERROR: '-$OPTARG' requires an argument"
         exit 1 ;;
      *) echo "ERROR: '-$OPTARG' is not a valid option"
         exit 1 ;;
    esac
done

# Use hr if available, but fallback
if ! [ -x "$(command -v hr)" ]; then
  function hr() {
    echo '-------------------'
  }
fi

DIRS=$(find $BASE -maxdepth 1 -type d)' '$(find $BASE -maxdepth 1 -type l);
SEARCHTERM=${@:$OPTIND}
TMPFILE="/tmp/searchfile.$(date +%Y%m%d%H%M%S).txt"

if [ "$SEARCHTERM" == "" ]; then
    echo 'Please provide a search term.'
    exit 1
fi

hr >> $TMPFILE
echo "Searching all repos for \"$SEARCHTERM\"" | tee -a $TMPFILE
hr >> $TMPFILE
echo '' >> $TMPFILE


for repo in $DIRS; do
    if [ -d "$repo/.git" ]; then
        hr _ >> $TMPFILE
        echo "Searching $repo" | tee -a $TMPFILE
        echo '------' >> $TMPFILE
        echo '' >> $TMPFILE
        cd $repo
        git --no-pager grep --ignore-case "$SEARCHTERM" >> $TMPFILE
        echo '' >> $TMPFILE
        echo '' >> $TMPFILE
    fi
done;

clear;

TMPFILE="$TMPFILE +/$SEARCHTERM"
$CMD $TMPFILE
