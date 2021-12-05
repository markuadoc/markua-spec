# About This Document

*This formal specification of Markua was developed at Leanpub,
is written by Peter Armstrong,
is based on the CommonMark Spec by John MacFarlane,
and is licensed under the Creative Commons license CC-BY-SA 4.0.*

**This spec is currently UNIMPLEMENTED, and is subject to change!**

If you are a Leanpub author, **DO NOT READ THIS**.

Instead, you should be reading the [Markua Manual](https://leanpub.com/markua/read),
not this document!

The Markua Manual documents the version of Markua 0.1 which is used on Leanpub.

This document is a bunch of forward-looking statements which guide the ongoing
development of Markua 0.29 on Leanpub. We have **not yet shipped the beta** of
Markua 0.29, so at the moment, this document is just for interest and feedback,
not actual use by authors.

This document is also subject to change: I make mistakes, and as we implement
this specification on Leanpub, I'm realizing just how many!

* * *

This is the [Markua Spec](http://markua.com`), written by
[Peter Armstrong](https://twitter.com/peterarmstrong).

The Markua Spec is based on the CommonMark Spec, whose author is
[John MacFarlane](https://johnmacfarlane.net/).

This document also incorporates the specification of three of the five GitHub
Flavored Markdown (GFM) extensions from the [GFM
Spec](https://github.github.com/gfm/).

Like the CommonMark Spec and the GFM Spec, the Markua Spec is licensed under
the Creative Commons license
[CC-BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

This document has two types of intended readers:

1. authors with advanced questions about Markua syntax
2. developers implementing Markua Processors

The Introduction contains a number of introductory sections about Markua and
its relationship to Markdown, CommonMark and GFM. It also contains sections
which discuss Leanpub, to minimize confusion for Leanpub authors who encounter
this document.

If you're going to read this document, you really should read the
[Introduction](http://markua.com/#introduction),
even if you normally skip them.

# Branches

Markua is being specified on the `master` branch.
Leanpub Flavoured Markdown (LFM) is being specified on the `lfm` branch.

# Building the Spec

To build the spec on a Mac, you need to have Lua 5.1 (NOT 5.4) installed, it seems.

Homebrew wants to install Lua 5.4 when you do `brew install lua` or `brew install luarocks`.

So, instead, you do this:

1. Install Lua:

```
brew install lua@5.1
```

2. Install luarocks

```
brew install luarocks
```

3. Install lcmark:

```
luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install lcmark
```

4. Ensure `lua` points at the 5.1 version, not the 5.4 version (which is not used since yaml does not work yet):

TODO - fix these:

```
~/repos/markua-spec[v_0_30]$ which luarocks
~/repos/markua-spec[v_0_30]$ brew uninstall luarocks
Error: No such keg: /opt/homebrew/Cellar/luarocks
~/repos/markua-spec[v_0_30]$ brew install lua@5.3
==> Downloading https://ghcr.io/v2/homebrew/core/lua/5.3/manifests/5.3.6-2
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/lua/5.3/blobs/sha256:c8b7e58e974dbd961e98ca2454e079834d9ab587a8793421541d9f3819b94499
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:c8b7e58e974dbd961e98ca2454e079834d9ab587a8793421541d9f3819b94499?se=2021-12-04T19%3A10%3A00Z&sig=Dmyhi6wn0ZSoyDJWnWkMrIRI57VoN
######################################################################## 100.0%
==> Pouring lua@5.3--5.3.6.arm64_monterey.bottle.2.tar.gz
==> Caveats
You may also want luarocks:
  brew install luarocks

lua@5.3 is keg-only, which means it was not symlinked into /opt/homebrew,
because this is an alternate version of another formula.

If you need to have lua@5.3 first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/lua@5.3/bin:$PATH"' >> /Users/peter/.bash_profile

For compilers to find lua@5.3 you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/lua@5.3/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/lua@5.3/include"

For pkg-config to find lua@5.3 you may need to set:
  export PKG_CONFIG_PATH="/opt/homebrew/opt/lua@5.3/lib/pkgconfig"

==> Summary
🍺  /opt/homebrew/Cellar/lua@5.3/5.3.6: 28 files, 407.3KB
==> Running `brew cleanup lua@5.3`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

TODO

/opt/homebrew/opt[stable]$ brew unlink lua
Unlinking /opt/homebrew/Cellar/lua/5.4.3_1... 18 symlinks removed.
/opt/homebrew/opt[stable]$ brew link lua@5.3 --overwrite
Linking /opt/homebrew/Cellar/lua@5.3/5.3.6... 17 symlinks created.

If you need to have this software first in your PATH instead consider running:
  echo 'export PATH="/opt/homebrew/opt/lua@5.3/bin:$PATH"' >> /Users/peter/.bash_profile
  
  
  

cd /opt/homebrew/bin
rm lua
ln -s ../Cellar/lua@5.1/5.1.5_8/bin/lua5.1 lua
```

5. Build the spec:

```
rm spec.html && make spec.html && open spec.html
```

Note that step 4 can also be run with the `./go.sh` script:

```
./go.sh
```


# DEBUG

```
$ brew install lua@5.1
Running `brew update --preinstall`...
==> Auto-updated Homebrew!
Updated 2 taps (homebrew/core and homebrew/cask).
==> Updated Formulae
Updated 9 formulae.
==> Updated Casks
Updated 1 cask.

Warning: lua@5.1 has been deprecated because it is not supported upstream!
==> Downloading https://ghcr.io/v2/homebrew/core/lua/5.1/manifests/5.1.5_8
Already downloaded: /Users/peter/Library/Caches/Homebrew/downloads/4f1ccc862fac8e5e7da01ec87696d6d944658205e97bd970968efdabefddef83--lua@5.1-5.1.5_8.bottle_manifest.json
==> Downloading https://ghcr.io/v2/homebrew/core/lua/5.1/blobs/sha256:de6f49207593ea1ff60752fbda844d4be34d92de796f758c9e0e5f3dd329fab7
Already downloaded: /Users/peter/Library/Caches/Homebrew/downloads/9fe72afcc27ae94c4dc56e693e42785a37e0a6a3014b310d1920055d8394befc--lua@5.1--5.1.5_8.arm64_monterey.bottle.tar.gz
==> Pouring lua@5.1--5.1.5_8.arm64_monterey.bottle.tar.gz
Unlinking /opt/homebrew/Cellar/lua@5.3/5.3.6... 11 symlinks removed.
==> Caveats
You may also want luarocks:
  brew install luarocks
==> Summary
🍺  /opt/homebrew/Cellar/lua@5.1/5.1.5_8: 22 files, 393.2KB
==> Running `brew cleanup lua@5.1`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
$ brew install luarocks
==> Downloading https://ghcr.io/v2/homebrew/core/lua/manifests/5.4.3_1
Already downloaded: /Users/peter/Library/Caches/Homebrew/downloads/beb4c946b907cea7c4aca5ff6c388aa71ceeaaf1cdf9b50e9a48187d7a95da1c--lua-5.4.3_1.bottle_manifest.json
==> Downloading https://ghcr.io/v2/homebrew/core/lua/blobs/sha256:d0ac5ebb4064dea9bb4afa547eb634f16ceed7662c653c3a9c24d28c4a2b75ec
Already downloaded: /Users/peter/Library/Caches/Homebrew/downloads/fce354e3bcd5c7e745efcb77ca0d0c4543f70d0f69368fcf1bed58de71aaeee9--lua--5.4.3_1.arm64_monterey.bottle.tar.gz
==> Downloading https://ghcr.io/v2/homebrew/core/luarocks/manifests/3.8.0
Already downloaded: /Users/peter/Library/Caches/Homebrew/downloads/765d8b545318d94a4bd69a92654e8b530963835d93b3dad85f97981b856372df--luarocks-3.8.0.bottle_manifest.json
==> Downloading https://ghcr.io/v2/homebrew/core/luarocks/blobs/sha256:3c1d3b809e453e3754e920e6b915ebe9ad2562e7de23bcea9dff62e253681882
Already downloaded: /Users/peter/Library/Caches/Homebrew/downloads/fa71e58cc4ed0d72c328c3829f5d94446f61147178a8d8fd4d2ea21c4af0f302--luarocks--3.8.0.arm64_monterey.bottle.tar.gz
==> Installing dependencies for luarocks: lua
==> Installing luarocks dependency: lua
==> Pouring lua--5.4.3_1.arm64_monterey.bottle.tar.gz
🍺  /opt/homebrew/Cellar/lua/5.4.3_1: 29 files, 792.8KB
==> Installing luarocks
==> Pouring luarocks--3.8.0.arm64_monterey.bottle.tar.gz
==> Caveats
LuaRocks supports multiple versions of Lua. By default it is configured
to use Lua5.4, but you can require it to use another version at runtime
with the `--lua-dir` flag, like this:

  luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install say
==> Summary
🍺  /opt/homebrew/Cellar/luarocks/3.8.0: 105 files, 719.7KB
==> Running `brew cleanup luarocks`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> luarocks
LuaRocks supports multiple versions of Lua. By default it is configured
to use Lua5.4, but you can require it to use another version at runtime
with the `--lua-dir` flag, like this:

  luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install say
```

Then trying to install luarocks for 5.1

```
$ sudo luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install lcmark
Password:
Installing https://luarocks.org/lcmark-0.29.0-5.src.rock
Missing dependencies for lcmark 0.29.0-5:
   cmark >= 0.29.0 (not installed)
   yaml >= 1.1 (not installed)
   lpeg >= 0.12 (not installed)
   optparse >= 1.0.1 (not installed)

lcmark 0.29.0-5 depends on lua >= 5.1 (5.1-1 provided by VM)
lcmark 0.29.0-5 depends on cmark >= 0.29.0 (not installed)
Installing https://luarocks.org/cmark-0.29.0-1.src.rock

env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c cmark_wrap.c -o cmark_wrap.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/blocks.c -o ext/blocks.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/houdini_html_u.c -o ext/houdini_html_u.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/references.c -o ext/references.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/buffer.c -o ext/buffer.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/html.c -o ext/html.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/render.c -o ext/render.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/cmark.c -o ext/cmark.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/inlines.c -o ext/inlines.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/scanners.c -o ext/scanners.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/cmark_ctype.c -o ext/cmark_ctype.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/iterator.c -o ext/iterator.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/utf8.c -o ext/utf8.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/commonmark.c -o ext/commonmark.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/latex.c -o ext/latex.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/xml.c -o ext/xml.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/houdini_href_e.c -o ext/houdini_href_e.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/man.c -o ext/man.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/houdini_html_e.c -o ext/houdini_html_e.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c ext/node.c -o ext/node.o -I. -Iext
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -bundle -undefined dynamic_lookup -all_load -o cmark.so cmark_wrap.o ext/blocks.o ext/houdini_html_u.o ext/references.o ext/buffer.o ext/html.o ext/render.o ext/cmark.o ext/inlines.o ext/scanners.o ext/cmark_ctype.o ext/iterator.o ext/utf8.o ext/commonmark.o ext/latex.o ext/xml.o ext/houdini_href_e.o ext/man.o ext/houdini_html_e.o ext/node.o
No existing manifest. Attempting to rebuild...
cmark 0.29.0-1 is now installed in /Users/peter/.luarocks (license: BSD2)

lcmark 0.29.0-5 depends on yaml >= 1.1 (not installed)
Installing https://luarocks.org/yaml-1.1.2-1.src.rock
Missing dependencies for yaml 1.1.2-1:
   lub >= 1.0.3, < 2 (not installed)

yaml 1.1.2-1 depends on lua >= 5.1, < 5.4 (5.1-1 provided by VM)
yaml 1.1.2-1 depends on lub >= 1.0.3, < 2 (not installed)
Installing https://luarocks.org/lub-1.1.0-1.src.rock
Missing dependencies for lub 1.1.0-1:
   luafilesystem >= 1.4.0 (not installed)

lub 1.1.0-1 depends on lua >= 5.1, < 5.4 (5.1-1 provided by VM)
lub 1.1.0-1 depends on luafilesystem >= 1.4.0 (not installed)
Installing https://luarocks.org/luafilesystem-1.8.0-1.src.rock

luafilesystem 1.8.0-1 depends on lua >= 5.1 (5.1-1 provided by VM)
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/lfs.c -o src/lfs.o
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -bundle -undefined dynamic_lookup -all_load -o lfs.so src/lfs.o
luafilesystem 1.8.0-1 is now installed in /Users/peter/.luarocks (license: MIT/X11)

lub 1.1.0-1 is now installed in /Users/peter/.luarocks (license: MIT)

env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/api.c -o src/api.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/b64.c -o src/b64.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/dumper.c -o src/dumper.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/emitter.c -o src/emitter.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/loader.c -o src/loader.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/lyaml.c -o src/lyaml.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/parser.c -o src/parser.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/reader.c -o src/reader.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/scanner.c -o src/scanner.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/strtod.c -o src/strtod.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c src/writer.c -o src/writer.o -Isrc
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -bundle -undefined dynamic_lookup -all_load -o yaml/core.so src/api.o src/b64.o src/dumper.o src/emitter.o src/loader.o src/lyaml.o src/parser.o src/reader.o src/scanner.o src/strtod.o src/writer.o
yaml 1.1.2-1 is now installed in /Users/peter/.luarocks (license: MIT)

lcmark 0.29.0-5 depends on lpeg >= 0.12 (not installed)
Installing https://luarocks.org/lpeg-1.0.2-1.src.rock

lpeg 1.0.2-1 depends on lua >= 5.1 (5.1-1 provided by VM)
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c lpcap.c -o lpcap.o
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c lpcode.c -o lpcode.o
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c lpprint.c -o lpprint.o
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c lptree.c -o lptree.o
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -O2 -fPIC -I/opt/homebrew/opt/lua@5.1/include/lua5.1 -c lpvm.c -o lpvm.o
env MACOSX_DEPLOYMENT_TARGET=10.8 gcc -bundle -undefined dynamic_lookup -all_load -o lpeg.so lpcap.o lpcode.o lpprint.o lptree.o lpvm.o
lpeg 1.0.2-1 is now installed in /Users/peter/.luarocks (license: MIT/X11)

lcmark 0.29.0-5 depends on optparse >= 1.0.1 (not installed)
Installing https://luarocks.org/optparse-1.4-1.src.rock

optparse 1.4-1 depends on lua >= 5.1, < 5.5 (5.1-1 provided by VM)
optparse 1.4-1 is now installed in /Users/peter/.luarocks (license: MIT/X11)

lcmark 0.29.0-5 is now installed in /Users/peter/.luarocks (license: BSD2)

$ luarocks list

Rocks installed for Lua 5.4
---------------------------

$ luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 list

Rocks installed for Lua 5.1
---------------------------

cmark
   0.29.0-1 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1

lcmark
   0.29.0-5 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1

lpeg
   1.0.2-1 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1

luafilesystem
   1.8.0-1 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1

lub
   1.1.0-1 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1

optparse
   1.4-1 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1

yaml
   1.1.2-1 (installed) - /Users/peter/.luarocks/lib/luarocks/rocks-5.1
```

Trying again...

```
/opt/homebrew/bin[stable]$ ls -lh lua*
lrwxr-xr-x  1 peter  admin    29B  4 Dec 14:35 lua -> ../Cellar/lua/5.4.3_1/bin/lua
lrwxr-xr-x  1 peter  admin    37B  4 Dec 14:35 lua-5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/lua-5.1
lrwxr-xr-x  1 peter  admin    33B  4 Dec 14:35 lua-5.4 -> ../Cellar/lua/5.4.3_1/bin/lua-5.4
lrwxr-xr-x  1 peter  admin    36B  4 Dec 14:35 lua5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/lua5.1
lrwxr-xr-x  1 peter  admin    32B  4 Dec 14:35 lua5.4 -> ../Cellar/lua/5.4.3_1/bin/lua5.4
lrwxr-xr-x  1 peter  admin    30B  4 Dec 14:35 luac -> ../Cellar/lua/5.4.3_1/bin/luac
lrwxr-xr-x  1 peter  admin    38B  4 Dec 14:35 luac-5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/luac-5.1
lrwxr-xr-x  1 peter  admin    34B  4 Dec 14:35 luac-5.4 -> ../Cellar/lua/5.4.3_1/bin/luac-5.4
lrwxr-xr-x  1 peter  admin    37B  4 Dec 14:35 luac5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/luac5.1
lrwxr-xr-x  1 peter  admin    33B  4 Dec 14:35 luac5.4 -> ../Cellar/lua/5.4.3_1/bin/luac5.4
lrwxr-xr-x  1 peter  admin    37B  4 Dec 14:35 luarocks -> ../Cellar/luarocks/3.8.0/bin/luarocks
lrwxr-xr-x  1 peter  admin    43B  4 Dec 14:35 luarocks-admin -> ../Cellar/luarocks/3.8.0/bin/luarocks-admin
/opt/homebrew/bin[stable]$ rm lua
/opt/homebrew/bin[stable]$ ln -s ../Cellar/lua@5.1/5.1.5_8/bin/lua-5.1 lua
/opt/homebrew/bin[stable]$ ls -lh lua*
lrwxr-xr-x  1 peter  admin    37B  4 Dec 18:22 lua -> ../Cellar/lua@5.1/5.1.5_8/bin/lua-5.1
lrwxr-xr-x  1 peter  admin    37B  4 Dec 14:35 lua-5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/lua-5.1
lrwxr-xr-x  1 peter  admin    33B  4 Dec 14:35 lua-5.4 -> ../Cellar/lua/5.4.3_1/bin/lua-5.4
lrwxr-xr-x  1 peter  admin    36B  4 Dec 14:35 lua5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/lua5.1
lrwxr-xr-x  1 peter  admin    32B  4 Dec 14:35 lua5.4 -> ../Cellar/lua/5.4.3_1/bin/lua5.4
lrwxr-xr-x  1 peter  admin    30B  4 Dec 14:35 luac -> ../Cellar/lua/5.4.3_1/bin/luac
lrwxr-xr-x  1 peter  admin    38B  4 Dec 14:35 luac-5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/luac-5.1
lrwxr-xr-x  1 peter  admin    34B  4 Dec 14:35 luac-5.4 -> ../Cellar/lua/5.4.3_1/bin/luac-5.4
lrwxr-xr-x  1 peter  admin    37B  4 Dec 14:35 luac5.1 -> ../Cellar/lua@5.1/5.1.5_8/bin/luac5.1
lrwxr-xr-x  1 peter  admin    33B  4 Dec 14:35 luac5.4 -> ../Cellar/lua/5.4.3_1/bin/luac5.4
lrwxr-xr-x  1 peter  admin    37B  4 Dec 14:35 luarocks -> ../Cellar/luarocks/3.8.0/bin/luarocks
lrwxr-xr-x  1 peter  admin    43B  4 Dec 14:35 luarocks-admin -> ../Cellar/luarocks/3.8.0/bin/luarocks-admin
/opt/homebrew/bin[stable]$ 
```

Then, this causes:

```
~/repos/markua-spec[v_0_30]$ ./go.sh 
lua tools/make_spec.lua html < spec.txt > spec.html
lua: tools/make_spec.lua:1: module 'lcmark' not found:
	no field package.preload['lcmark']
	no file './lcmark.lua'
	no file '/opt/homebrew/share/lua/5.1/lcmark.lua'
	no file '/opt/homebrew/share/lua/5.1/lcmark/init.lua'
	no file '/opt/homebrew/lib/lua/5.1/lcmark.lua'
	no file '/opt/homebrew/lib/lua/5.1/lcmark/init.lua'
	no file './lcmark.so'
	no file '/opt/homebrew/lib/lua/5.1/lcmark.so'
	no file '/opt/homebrew/lib/lua/5.1/loadall.so'
stack traceback:
	[C]: in function 'require'
	tools/make_spec.lua:1: in main chunk
	[C]: ?
make: *** [spec.html] Error 1
~/repos/markua-spec[v_0_30]$ 
```

The lcmark.lua is in:

```
/Users/peter/.luarocks/share/lua/5.1/lcmark.lua
```

Presumably, this is because it was installed locally instead of globally.
