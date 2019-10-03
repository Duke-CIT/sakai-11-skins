#!/usr/bin/env bash

echo "bin/uglify.sh $1 start"

MORPHEUS='19.x/morpheus-master'

DATE=`date '+%a, %d %b %Y %H:%M:%S %Z'`
URLDATE=${DATE// /%20}
rm -rf dist/$1/js
mkdir dist/$1/js

if [ $1 == "19.x/duke-default" ]; then
    terser src/$MORPHEUS/js/src/*.js src/$1/js/src/*.js \
           -o dist/$1/js/morpheus.scripts.min.js -c \
           -b max_line_len=650,beautify=false
else
    terser src/$MORPHEUS/js/src/*.js src/19.x/duke-default/js/src/*.js src/$1/js/src/*.js \
        -o dist/$1/js/morpheus.scripts.min.js -c \
        -b max_line_len=650,beautify=false
fi

# terser dist/$1/js/morpheus.scripts.js -m -o dist/$1/js/morpheus.scripts.min.js -b max_line_len=650,beautify=false --verbose

FIND="<dd>TIME<\/dd>"  
REPLACE="<dd>$DATE<\/dd>"

sed -ir "s/${FIND}/${REPLACE}/g" dist/$1/js/morpheus.scripts.min.js
rm dist/$1/js/morpheus.scripts.min.jsr

FIND="built%20on-\(.*\)-blue"
REPLACE="built%20on-$URLDATE-blue"
sed -ir "s/${FIND}/${REPLACE}/g" README.md
rm README.mdr

mkdir dist/$1/js/lib
cp -R src/$MORPHEUS/js/lib/* dist/$1/js/lib/

mkdir dist/$1/js/ie
cp -R src/$MORPHEUS/js/ie/* dist/$1/js/ie/

echo "bin/uglify.sh $1 done"
