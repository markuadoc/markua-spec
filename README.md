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

4. Build the spec:

```
rm spec.html && make spec.html && open spec.html
```

Note that step 4 can also be run with the `./go.sh` script:

```
./go.sh
```
