#!/bin/bash
set -e

echo -n "Enter the version for this release: "

read ver

if [ ! $ver ]; then 
	echo "Invalid version."
	exit
fi

name="select2"
js="$name.js"
mini="$name.min.js"
css="$name.css"
release="$name-$ver"
tag="$ver"
branch="build-$ver"
curbranch=`git branch | grep "*" | sed "s/* //"`
timestamp=$(date)
tokens="s/@@ver@@/$ver/g;s/\@@timestamp@@/$timestamp/g"
remote="github"

echo "Minifying..."

echo "/*" > "$mini"
cat LICENSE | sed "$tokens" >> "$mini"
echo "" >> "$mini"
echo "Patched for AXEL-FORMS (http://ssire.github.io/axel-forms/) by S. Sire (http://www.oppidoc.fr)" >> "$mini"
echo "*/" >> "$mini"

curl -s \
  --data-urlencode "js_code@$js" \
  http://marijnhaverbeke.nl/uglifyjs \
  >> "$mini"

echo "Done"
