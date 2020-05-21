# About This Document

This is the specification of **Markua 0.29**. It is based on the CommonMark 0.29
specification.

Markua evolved at Leanpub, and is being developed as an open specification by
Peter Armstrong. Anyone is free to implement any version of the Markua spec
or of the LFM spec.

# For Leanpub Authors

If you're a Leanpub author writing in Markua, this is **NOT** what you should be
reading.

There are currently two ways to write in plain text on Leanpub. These are their
user manuals:

1. [Leanpub Flavoured Markdown (LFM)](https://leanpub.com/lfm/read)
2. [Markua](https://leanpub.com/markua/read)

### Leanpub's Current Markua Implementation

Leanpub's current Markua implementation is **Markua 0.10 Quirks Mode**. To learn
what this means, read on.

## About Leanpub's Markdown Support and Specifications

Leanpub Flavoured Markdown (LFM) was started in 2011, and Markua 0.10 was
started in 2014. Both of these dates are before the CommonMark specication was
created, so obviously neither LFM nor Markua 0.10 were historically based on
the CommonMark spec.

However, the CommonMark spec is the best specification of a Markdown dialect,
and we expect that it will become the defacto standard.

So, Leanpub needs to redefine LFM and Markua 0.10 from a starting point of the
CommonMark 0.29 spec, instead of starting with Markdown as originally described
by John Gruber.

## Three Specifications

As such, there are separate specifications for the following, and they are
**ALL** based on the **CommonMark 0.29** spec:

1. [LFM spec](http://markua.com/spec/lfm)
2. [Markua 0.10 spec](http://markua.com/spec/markua010)
3. [Markua 0.29 spec](http://markua.com/spec/markua029)

These specifications will not exactly match Leanpub's current behaviour when
parsing LFM or Markua 0.10. However, they will be really close, and this will
enable the development of converters between LFM, Markua 0.10 and Markua 0.29.
This will help us support authors with existing Leanpub books who want to
migrate to the latest version of Markua.

## Three Supported Markdown Dialects

As such, there will eventually be at least three supported Markdown dialects on
Leanpub:

1. LFM
2. Markua 0.10
3. Markua 0.29

We will launch our Markua 0.29 support in beta, and iterate until we have a
completed version.

## Quirks Mode

Furthermore, roughly when we launch the Markua beta, Leanpub will also launch
LFM and Markua 0.10 "Spec Mode" support. When we do this, the existing LFM and
Markua 0.10 modes will be rebranded as the "Quirks Mode" of LFM and Markua 0.10.

This will enable authors of existing LFM books and Markua 0.10 books and courses
to make a choice:

1. Leave their book or course in Quirks Mode, for unchanged behaviour and
   performance.
2. Switch their book or course to Spec Mode, for faster book or course
   generation and better compliance with the LFM or Markua 0.10 specs.
3. Click a button to save a version of their existing manuscript and then
   automatically convert their LFM or Markua 0.10 manuscript into a Markua 0.29
   manuscript.

There is no Quirks Mode for Markua 0.29, since we do not have an existing
Markua 0.29 implementation that we need to support. Authors will be able to
automatically migrate their books or courses into Markua 0.29 with a converter.

### At Least Five Markdown Writing Modes

With the launch of Quirks Mode and Spec Mode, there will be five Markdown-based
writing modes on Leanpub:

1. LFM (Quirks Mode)
2. LFM (Spec Mode)
3. Markua 0.10 (Quirks Mode)
4. Markua 0.10 (Spec Mode)
5. Markua 0.29

Again, there is no Quirks Mode for Markua 0.29.

Now, it is expected that Markua will continue to evolve, especially in its
support of courses. (For example, we have received reasonable requests for
additional question types to be added to Markua.) However, any new Markua
features such as this will require a version bump in the Markua spec.

So, we expect that in future there will be at least 6 writing modes on Leanpub,
as Markua continues to evolve.

This is admittedly complex. Given that Leanpub has existed for over a decade,
and has actively worked on improving its book and course generation engine,
this complexity is inevitable.

However, we will try to make things simpler for new authors, by defaulting
new books and courses to the latest stable version of Markua.

This is the roadmap for the default Markua version:

1. Markua 0.10 Quirks Mode (current)
2. Markua 0.10 Spec Mode
3. Markua 0.29

### Markua 0.10 Quirks Mode vs. Markua 0.10 Spec Mode

To repeat, Leanpub's current Markua implementation is Markua 0.10 Quirks Mode.

The most notable difference between Spec Mode and Quirks Mode in Markua 0.10
is Setext header support. Quirks Mode (i.e. current Leanpub) does **NOT**
support Setext headers, whereas Spec Mode of Markua 0.10 spec DOES support
Setext headers.

So, if you try to use a Setext header in Markua 0.10 Quirks Mode it won't do
what you want. However, it will do what you want in Markua 0.10 Spec Mode, and
it will be converted as a Setext header when using a converter to upgrade your
book or course to Markua 0.29.

### Leanpub's Markdown Converter Roadmap

Leanpub is planning to build converters based on the **Spec Mode** (NOT the
Quirks Mode) of the different Markdown dialects it has supported over the years.

Specifically, Leanpub is planning to develop the following:

1. A Pandoc reader for LFM (Spec Mode)
2. A Pandoc reader for Markua 0.10 (Spec Mode)
3. A Pandoc reader for Markua 0.29
4. A Pandoc writer for LFM (Spec Mode)
5. A Pandoc writer for Markua 0.10 (Spec Mode)
6. A Pandoc writer for Markua 0.29

Now, the Pandoc writer for LFM and Markua 0.10 are not as high a priority as the
Pandoc writer for Markua 0.29. However, these writers should help the development
of their readers, so we're planning to build them all. Also, they will help
authors downgrade if needed.

Again, the Pandoc readers and writers for LFM and Markua will be based on their
Spec Mode variants, not their Quirks Mode variants. It is not a high priority
us to develop deliberately buggy Pandoc readers and writers to support Quirks
Mode in Pandoc.

### Forward-Looking Statements

The above is a collection of forward-looking statements which accurately reflect
our plans as of 2020-05-20.

However, there is no promise that any of the above will actually happen, and we
are not providing any estimates for release dates. Software estimation is hard.