#!/bin/sh
#
# escape.sh - Escapes angle brackets in text files
# Written by Samuel Bierwagen
#
# Turns angle brackets into &lt; and &gt; HTML entities.
# With --irc, replaces the first 8 columns (the timestamp) with an 
# opening angle bracket, using an ugly hack.
#
# This is free and unencumbered software released into the public domain.

if [[ $* == *--irc* ]]
then
    sed -i 's/\&/\&amp;/g' $2
    sed -i 's/>/\&gt;/g' $2
    sed -i 's/^......../\&lt;/g' $2
else
    sed -i 's/\&/\&amp;/g' $1
    sed -i 's/</\&lt;/g' $1
    sed -i 's/>/\&gt;/g' $1
fi
