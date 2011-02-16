#!/bin/sh
#
# bar.sh - Makes a HTML file, generates the navigation bar, and adds it to the git repo
#
# Run it from the top level directory
#
# Usage: ./bar.sh example/foo/baz.html

FILE=$1

if [ -z "$FILE" ]
   then
echo "[!] This script needs a HTML file as an input."
   exit 1
fi

if [ ! -f "$FILE" ]
   then
echo "[!] File does not exist."
   exit 1
fi

if [ -z "$NAME" ]
    then
echo "[!] Please specify a name."
    exit 1
fi

