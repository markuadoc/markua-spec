#!/bin/sh
rm spec.html
./spec.sh
open spec.html
rm -f ~/repos/markua.org/public/index.html
cp spec.html ~/repos/markua.org/public/index.html
