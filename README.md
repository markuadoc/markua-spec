# A Note for Leanpub Authors

If you're a Leanpub author writing in Markua, this is **NOT** what you should be
reading.

There are currently two ways to write in plain text on Leanpub. These are their
user manuals:

1. [Leanpub Flavoured Markdown (LFM)](https://leanpub.com/lfm/read)
2. [Markua 0.10](https://leanpub.com/markua/read)

# About This Document

This is the specification of **Markua 0.29**. It is based on the CommonMark 0.29
specification.

Markua evolved at Leanpub, and is being specified as an open specification by
Peter Armstrong. Anyone is free to implement any version of the Markua spec
or of the LFM spec.

# About Leanpub's Markdown Support and Specifications

*(WARNING: The following contains forward-looking statements! No estimates
should be provided, and if they are, you should not believe any of them.)*

Leanpub Flavoured Markdown (LFM) and Markua 0.10 were both created before the
CommonMark specication was created.

However, the CommonMark specification is the best specification of a Markdown
dialect, and we expect that it will become the defacto standard.

So, Leanpub needs to redefine LFM and Markua 0.10 in terms of CommonMark,
instead of Markdown as originally described by John Gruber.

This way, it will be possible to develop converters for LFM and Markua 0.10,
in order to support authors with existing Leanpub books who want to migrate to
the latest version of Markua.

As such, there will eventually be three supported Markdown dialects on Leanpub:

1. LFM
2. Markua 0.10
3. Markua 0.29

We will launch our Markua 0.29 support in beta, and iterate until we have a
completed version.

Furthermore, when we launch the Markua beta, Leanpub will also enable our LFM
and Markua 0.10 dialect support to operate in "quirks mode" (to preserve their
current behaviour) or in "spec mode" to use a much faster and more
standards-compliant implementation.

So, eventually, there will be five writing modes on Leanpub:

1. LFM (quirks mode)
2. LFM (spec mode)
3. Markua 0.10 (quirks mode)
4. Markua 0.10 (spec mode)
5. Markua 0.29

Now, it is expected that Markua will continue to evolve, especially in its
support of courses. (For example, we have received reasonable requests for
additional question types to be added to Markua.) However, any new Markua
features such as this will require a version bump in the Markua spec.

So, we expect that in future there will be at least 6 writing modes on Leanpub,
as Markua continues to evolve.





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
