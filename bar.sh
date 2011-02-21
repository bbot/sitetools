#!/bin/sh
#
# bar.sh - Ultralightweight toy CMS.
# Copyright (C) 2011 Samuel Bierwagen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# --------------------------------------------------------------------
#
# The first time you run bar.sh, it creates the HTML file, generates the navigation bar, adds the creation time, and adds it to the git repo.
#
# Usage: ./bar.sh foo/baz.html
#
# The second time you run it, it checks to see if the file has been modified, and if it has, updates the modified time, runs HTML tidy to check for missing tags, GPG signs it with the default key, runs a git commit, then pushes it to the remote repo. Alternatively, it can scp it to a remote server, if your production pipeline doesn't use git.
#
# bar.sh can be run on a directory, in which case, it recursively searches the directory tree for modified files, publishing them as it finds them.
#
# Usage: ./bar.sh foo/
#
# Git commit comments can be added with the -m tag.
#
# Usage: ./bar.sh -m 'changing DOCTYPEs to HTML8' foo/
#
# bar.sh outputs valid HTML5, and generates well-formed semantic HTML, which, to a first approximation, nobody at all cares about. But this is my toy CMS, and I'll do what I want.
#
# bar.sh does not work out of the box. Everything in [ALLCAPS SQUARE BRACKETS] is a site-specific setting, and should be changed by the end-user.

FILE=$1
# We stick the commit message inside strong quotes so you can use arbitrary text.
COMMIT_MESSAGE=\'$2\'

if [ -z "$FILE" ]
   then
echo "[!] This script needs a HTML file or a directory as an input."
   exit 1
fi

# Checks to see if the file exists, and if it doesn't, makes it.
if [ ! -f "$FILE" ]
   then
    make page
   exit 1
fi

# Main loop.

for (( i=1; i <= $NUMBER_OF_FILES; i=i+1 ))
do
    # Validate HTML, and error out if it fails.
    if [ foobar ]
	then
	tidy $FILE
	exit 1
    fi

    # Now that we know the HTML is good, we can sign it...
    gpg --clearsign $FILE

    # ...and add it to git.
    git add "$FILE".asc
    git commit -a -m $COMMIT_MESSAGE
    git push origin master

    # Or SCP it, if no git.
    #scp "$FILE"* [USER]@[REMOTE SERVER]:[PATH TO WWWROOT]
done