#!/bin/sh

# How to use ./push filename message number

if [ $# -eq 0 ]; then
    echo No file
    exit 1

elif [ $# -lt 3 ]; then
    echo Expected 3 args. Got $#.
    exit 2

fi

cd ~/afs/thomasBazar/piscine/thomas.emerdjian-piscine-2024/$1

make clean
rm -rf tests
rm -f main.c
mv src/* .
rm -rf src
rm -f Makefile
rm -f *.[!hc]

git add *.[ch]

git commit -m "$2"

git tag -a exercises-$1-v$3 -m "$2"

git push --follow-tags
