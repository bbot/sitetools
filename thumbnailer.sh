#!/bin/sh
#
# Thumbnailer, Watermarker, HTML generator, uploader.
#
# Takes an image file, renames it to whatever you tell it to, produces two watermarked, resized copies (500 and 1200 pixels wide) and uploads them to a remote site using scp.
# 
# This is a dummy version. You want to replace the strings inside square brackets with your chosen text. Variables are in UPPERCASE, don't mess with those.
#
# The watermarker is (in my ever so humble opinion) fairly clever. [Main watermark text] is appended at the bottom of the image in white text over a black bar, in 16-point text, like the ICHC family of sites. It doesn't cover up any part of the image, but instead adds it to the bottom.
# Since this can fairly trivially be snipped off, it also prints [small watermark text] in 9-point 50% gray text, 200 pixels right and 240 pixels up from the center of the image.
# This isn't a very high-security watermarker, since I don't hate my users. You can increase the obviousness of the watermarks, if you wish.
#
# Arguments are of the form ./thumbnailer.sh SOURCEFILE.extension TARGETNAME
# It's smart enough to read the extension off the source file, but not so smart as to notice if you put an extension on the target name. Don't put an extension on the target name.

FILE=$1
NAME=$2

if [ -z "$FILE" ]
   then
   echo "[!] This script needs an image file as an input."
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

EXTENSION=${FILE##*.}

echo '<a href="[http://example.com]'$NAME.$EXTENSION'"><img src="[http://example.com/]'$NAME'-thumb.'$EXTENSION'"></a>'

convert -verbose -geometry 1200 -quality 90 -background black -gravity Center -pointsize 9 -fill gray50 -draw "translate 200,-240 text 0,0 '[small watermark text]'" -pointsize 16 -fill White label:'[main watermark text]' -append  "$FILE" "$NAME.$EXTENSION"

convert -verbose -geometry 500 -quality 80 "$FILE" "$NAME"-thumb".$EXTENSION"

scp $NAME.$EXTENSION $NAME"-thumb".$EXTENSION [user@example.com]
