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
