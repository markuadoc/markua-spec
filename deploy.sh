#!/bin/sh
rm spec.html
rm spec.txt
cp spec.md spec.txt
./spec.sh
open spec.html
rm -f ~/repos/markua.org/public/index.html
cp spec.html ~/repos/markua.org/public/index.html
