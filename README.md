# A Note for Leanpub authors

If you're a Leanpub author writing in Markua, this is **NOT** what you should be
reading. Leanpub's current Markua implementation (of Markua 0.10) is documented
at [The Markua Manual](https://leanpub.com/markua/read).

# About This Document

This is the specification of Markua 0.29.

Markua evolved at Leanpub, and is being specified as an open specification by
Peter Armstrong. Anyone is free to implement any version of the Markua spec.

There are currently two ways to write on Leanpub:

1. Leanpub Flavoured Markdown (LFM)
2. Markua 0.10

There will eventually be three ways to write on Leanpub:

1. LFM
2. Markua 0.10
3. Markua 0.29

The Markua 0.29 specification is based on the CommonMark 0.29 specification.

However, LFM and Markua 0.10 were both created before the CommonMark specication
was created. However, the CommonMark specification is the best specification of
a Markdown dialect, and it will become the defacto standard.

So, it is helpful to redefine both LFM and Markua 0.10 as dialects of the
CommonMark specification. As such, there are separate specifications for the
following, all based on the CommonMark specification:

1. LFM spec
2. Markua 0.10 spec
3. Markua 0.29 spec

These specifications will not match Leanpub's current behaviour when parsing
LFM or Markua 0.10 exactly. However, they will be really close, and this will
enable the development of converters between LFM, Markua 0.10 and Markua 0.29.

The most notable difference between Markua 0.10 as documented in the Markua 0.10
spec and as documented in the Markua manual on Leanpub is Setext headers:
Leanpub's Markua 0.10 implementation does not support Setext headers, whereas
the Markua 0.10 spec does support Setext headers.

So, Leanpub's Markua 0.10 implementation will be considered to have a bug, in
that it does not fully implement the Markua 0.10 spec. However, any converter
between Markua 0.10 and LFM or Markua 0.29 should be based on their respective
specs, not based on Leanpub implementations. A converter should not deliberately
reproduce any bugs which are present in Leanpub's implementations of LFM or
Markua 0.10.

Specifically, Leanpub is developing the following:

1. A Pandoc reader for LFM
2. A Pandoc reader for Markua 0.10
3. A Pandoc reader for Markua 0.29
4. A Pandoc writer for LFM
5. A Pandoc writer for Markua 0.10
6. A Pandoc writer for Markua 0.29

These Pandoc readers and writers will be based on the CommonMark-based specs of
LFM, Markua 0.10 and Markua 0.29. They will not deliberately recreate any
Leanpub bugs.
