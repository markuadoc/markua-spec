#!/bin/sh
rm spec.html
./spec.sh
rm -f ~/repos/markua.org/public/index.html
cp spec.html ~/repos/markua.org/public/index.html
