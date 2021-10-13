#!/bin/sh

git status || exit 7
rm -f */[!M]*[!.][!hc] */*.[!hc] main.c
git status
