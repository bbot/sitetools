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
# The first time you run bar.sh, it creates the HTML file, generates the navigation bar, adds the creation time, and adds it to the git repo. (git add then git commit)
#
# Usage: ./bar.sh foo/baz.html
#
# The second time you run it, it checks to see if the file has been modified, and if it has, updates the modified time, runs HTML tidy to check for missing tags, GPG signs it with the specified key, runs a git commit, then pushes it to the remote repo. Alternatively, it can scp it to a remote server, if your production pipeline doesn't use git.
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
# bar.sh does not work out of the box. Everything in ALLCAPS is a site-specific setting, and should be changed by the end-user.

FILE=$1

if [ -z "$FILE" ]
   then
echo "[!] This script needs a HTML file or a directory as an input."
   exit 1
fi

if [ ! -f "$FILE" ]
   then
echo "[!] File does not exist."
   exit 1
fi

