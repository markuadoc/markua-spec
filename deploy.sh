#!/bin/sh
rm spec.html
make spec.html
open spec.html
rm -f ~/repos/markua.org/public/spec/lfm.html
cp spec.html ~/repos/markua.org/public/spec/lfm.html

