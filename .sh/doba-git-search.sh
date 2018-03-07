#!/bin/bash

CMD=$EDITOR
BASE='/Users/jason/Sites/doba/docker.doba.com/src'
DIRS=$(find $BASE -maxdepth 1 -type d)' '$(find $BASE -maxdepth 1 -type l);

while getopts ":pq:" optname; do
	case "$optname" in
		"p")
			CMD=$PAGER
		;;
		"?")
			echo "Unknown option $OPTARG"
		;;
		*)
			# Should not occur
			echo "Unknown error while processing options"
		;;
	esac
	echo "OPTIND is now $OPTIND"
done

SEARCHTERM=${@:$OPTIND}
TMPFILE="/tmp/searchfile.$SEARCHTERM.`date +%Y%m%d%H%M%S`.txt"

if [ "$SEARCHTERM" == "" ]; then
	echo 'Please provide a search term.'
	exit 1
fi

echo '------' | tee $TMPFILE
echo "Searching all repos for \"$SEARCHTERM\"" | tee -a $TMPFILE
echo '------' | tee -a $TMPFILE
echo '' | tee -a $TMPFILE


for i in $DIRS; do
	if [ -d "$i/.git" ]; then
		echo '' | tee -a $TMPFILE
		echo '' | tee -a $TMPFILE
		echo '------' | tee -a $TMPFILE
		echo "Searching $i" | tee -a $TMPFILE
		echo '------' | tee -a $TMPFILE
		echo '' | tee -a $TMPFILE
		( cd $i && git --no-pager grep --ignore-case $SEARCHTERM | tee -a $TMPFILE )
	fi
done;

clear;

TMPFILE="$TMPFILE +/$SEARCHTERM"
$CMD $TMPFILE
