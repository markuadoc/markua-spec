# Introduction

## The magical typewriter

Imagine you owned a magical typewriter.

When you used this magical typewriter, you wrote with fewer distractions. You
didn't just write faster, you wrote better.

With your magical typewriter, you never worried about layout. The book formatted
itself.

You could hit a key on your magical typewriter to create an ebook from your
manuscript with one click.

All ebook formats would be created, and they'd all look good. You'd have PDF for
computers, MOBI for Kindle, and EPUB for everywhere else. The book would look
great on phones.

With your magical typewriter, you could publish your book before it was even
done, and get feedback from readers all over the world. You could automatically
share book updates with them. You would press one key on your magical typewriter
to publish a new version, and all your readers would have it instantly.

With your magical typewriter, you could easily compare your current manuscript
to any other version of your manuscript that had ever existed.

If you decided to make a print book, you could press a key on your magical
typewriter to get a print-ready PDF. All you would need to do is add a cover.
Or, if you wanted to work with a designer or publisher, you could press a
different key to generate InDesign. They could then use this as a starting point
for producing a beautiful print book.

Your magical typewriter could even transform your completed book manuscript into
a course that anyone in the world could take. All you'd need to do is to
add some quizzes and exercises and then press a key for your magical typewriter
to publish a massive open online course (MOOC) for you. The quizzes and exercises
would mark themselves, and students would get certificates based on how well
they did.

With your magical typewriter, you'd only have to do one thing:

Write.

Wouldn't it be great if such a magical typewriter existed?

It does. At [Leanpub](https://leanpub.com), we're building it.

But there's one requirement for this magical typewriter to exist: a simple,
coherent, open source, free, plain text format for a book or course manuscript.

This simple format will be the basis for the magical typewriter.

This simple format is called Markua.

This is its specification.

## How to write a novel in Markua

The Markua specification is long. However, the amount you need to learn to get
started is actually very short.

This example shows everything you need to know to write a novel in Markua:

~~~
# Chapter One

This is a paragraph. You just write.

Blank lines separate paragraphs. This is *italic* and **bold**.

* * *

That was a thematic break. "This is in quotes."

# Chapter Two

This is a paragraph in a new chapter.
~~~

Specifically, these are the rules:

1. Paragraphs are separated from other paragraphs by blank lines.
   (To add a blank line, add two consecutive newlines.)
2. To make a chapter heading, start a line with a pound sign (`#`), followed by
   a space and the name of the chapter.
3. To add a thematic break (also known as a scene break), put three asterisks
   (`* * *`) on a line with only whitespace.
4. Chapter headings and thematic breaks are separated from paragraphs by single
   newlines or blank lines. Blank lines are preferred for readability.
5. By default, single newlines in paragraphs turn into single spaces in the
   output, so you can manually wrap your paragraphs with newlines if you want.
   It's optional, however, and typically a waste of time.
6. Use `*one asterisk*` for italic and `**two asterisks**` for bold.
7. All other text and punctuation is typed normally.

That's it!

## How to write a computer programming book in Markua

The following example shows basically everything you need to know to write a
computer programming book in Markua:

~~~
# Chapter One

This is *italic* and **bold**.

Here's an image:

![a red apple](mac.jpg "The Original Mac")

## Section One

You can have bulleted and numbered lists, including nested lists:

1. foo
   a) lorem
   b) ipsum
2. bar
   * stuff
   * more stuff
3. baz

### A Sub-Section

You can even have definition lists!

term 1
: definition 1a
: definition 1b

term 2
: definition 2

## Another Section

Tables work too:

| Header 1  | Header 2  |
| --------- | --------- |
| Content 1 | Content 2 |
| Content 3 | Content 4 |

You can have external code samples:

![](hello.rb "Hello World in Ruby")

You can also inline code samples:

{title: "Hello World in Ruby"}
```ruby
puts "hello"
```

You can also include single lines of code like `puts "hello"` in paragraphs.

> Blockquotes are really easy too.
> --Peter Armstrong, *Markua Spec*

Finally, you can do that with math `d = v_i t + \frac{1}{2} a t^2`$ too.
~~~

As you can see, there is more syntax, including bulleted and numbered lists,
definition lists, tables, block quotes, external and inline code samples,
inline math, etc. However, even with all this, the Markua document remains
readable. Exactly how all of this syntax works is explained in the spec.

## How to write a course (MOOC) in Markua

To write a course in Markua, you can start from scratch or from a book
manuscript already formatted in Markua. Literally, all you need to do to turn a
book written in Markua into a course is to add some quizzes.

The following is a complete course, written in Markua:

```
# Lesson One: Markua

## Section One

Lessons can have sections (and sub-sections, etc.) just like book chapters.
You can use the same headings as you do for book chapters and sections.

This exercise shows two multiple choice questions.

{exercise, id: exercise1}
? How many letters are in the word Markdown?

a) 6
b) 7
C) 8

? How many unique letters are in the word CommonMark?

a) 6
B) 7
c) 8
{/exercise}

## Section Two

This quiz shows a multiple choice question and a fill in the blank question.

{quiz, id: quiz1}
? How many letters are in the word Markua?

a) 5
B) 6
c) 7

? How many unique letters are in the word Markua?

! 5
{/quiz}

# Lesson Two: Geography

This quiz shows two fill in the blank questions, with multiple answers and with
a regex answer.

{quiz, id: quiz2}
? What's the global capital of investment banking?

! New York
! London

? Where's the Eiffel Tower?

! /(Paris|France)/i
{/quiz}

# Lesson Three: Biology

This one-question quiz shows a multiple selection question.

{quiz, id: quiz3}
? Which of these are fruits?

T) apple
F) cow
F) lettuce
T) peach
T) pear
F) rice
{/quiz}
```

As this example shows, the syntax for writing normal content is the same as for
books. All that's different is the addition of quizzes and exercises.

Quizzes and exercises have the same type of content. However, with quizzes the
marks count toward your mark in the course, and with exercises they don't count.
For MOOCs, Markua supports multiple choice, fill in the blank and multiple
selection questions.

A multiple choice question has 2 or more answer choices, and 1 correct answer
choice. The correct answer choice is in a capital letter; incorrect answer
choices have lowercase letters.

A fill in the blank question consists of a question and a set of answers.
You can even use regular expressions for the answers.

A multiple selection question makes learners select every true answer, and leave
every false answer not selected.

As explained in the spec, there are more types of questions, and more options
with these types of questions. However, what is shown above is enough to create
a full MOOC out of a Markua book.

## Markua heading mapping to book and course structures

Markua is a way of writing books and courses. Books have things like chapters
and sections. Sometimes books have parts. Courses have lessons, which can be
organized in parts and grouped into sections.

In Markua, you make the appropriate headings using the standard atx or Setext
headings of Markdown, and these produce the appropriate level of heading.

* `h1` (with a `{class: part}` attribute list) produces a part heading
* `h1` (without a `{class: part}` attribute list) produces a chapter heading
* `h2` produces a section heading
* `h3` produces a sub-section heading
* `h4` produces a sub-sub-section heading
* `h5` produces a sub-sub-sub-section heading
* `h6` produces a sub-sub-sub-sub-section heading

With the Markdown atx headers, this is all really straightforward:

```
{class: part}
# A Part Heading (h1)

# A Chapter Heading (h1)

## A Section Heading (h2)

### A Sub-Section Heading (h3)

#### A Sub-Sub-Section Heading (h4)

##### A Sub-Sub-Sub-Section Heading (h5)

###### A Sub-Sub-Sub-Sub-Section Heading (h6)
```

With the Markdown Setext headers, you can only go to h2, so you can only make
part, chapter and section headings using Setext headers:

```
{class: part}
A Part Heading (h1)
===================

A Chapter Heading (h1)
======================

A Section Heading (h2)
----------------------
```

Both produce identical HTML for the part, chapter and section headings.
The `{class: part}` gets passed into the HTML as a `class="part"`, as is shown
in the [Part Headings](#part-headings-markua-extension-) extension. The other
headings all look identical to the Markdown headings as specified by CommonMark.
So, they are just discussed in the [ATX headings](#atx-headings) and
[Setext headings](#setext-headings) sections.

If you are using Setext headings and you realize you need sub-sections and lower,
you can need to use atx headings for them. It's up to you, however, whether you
convert the Setext headings for parts, chapters and sections. Mixing and
matching heading styles is ugly, but it is permitted.

## Markua: Markdown for books and courses

Markua, pronounced "mar-coo-ah", is Markdown for books and courses.

Markua is simple and powerful. When you are writing using Markua, you are
writing, not programming. Once you understand Markua's syntax, it fades into the
background.

Markua is based on [Markdown](http://daringfireball.net/projects/markdown/).
Markdown is a plain text format for writing text which can be transformed by
Markdown processors into HTML. Markdown was created by John Gruber, with help
from Aaron Swartz. Markdown was described by John Gruber as follows:

> Markdown is a text-to-HTML conversion tool for web writers. Markdown allows
you to write using an easy-to-read, easy-to-write plain text format, then
convert it to structurally valid XHTML (or HTML).

The primary reason that Markdown is a great way to write is that it was designed
to be this way:

> The overriding design goal for Markdown's formatting syntax is to make it as
readable as possible. The idea is that a Markdown-formatted document should be
publishable as-is, as plain text, without looking like it's been marked up with
tags or formatting instructions. While Markdown's syntax has been influenced by
several existing text-to-HTML filters, the single biggest source of inspiration
for Markdown's syntax is the format of plain text email.

Markua is a plain text format. Markua is basically Markdown, minus all inline
HTML except comments, plus a number of extensions to support everything you need
to write a book or create a course.

Markua manuscripts, called Markua documents, can be written however you want. On
a computer, you can use any text editor you want. Beginning authors can use
simple programs like Notepad or TextEdit or "distraction-free" programs like
iA Writer; authors who are programmers can use editors like Emacs, Vim, Atom or
VSCode. Since Markua is essentially a superset of Markdown, many programs which
support Markdown should already do a decent job of supporting Markua by default.

Markua maps Markdown syntax to book concepts, and then adds some new syntax and
concepts of its own.

Markua documents can be automatically transformed into every popular type of ebook
format. The computer programs which do this transformation are called Markua
Processors. These programs understand both Markua syntax and how to generate the
various output formats. An example Markua Processor is Leanpub: Leanpub can
output PDF, EPUB, MOBI and HTML from the same Markua document, and can even
output print-ready PDFs and InDesign files from them as well.

Markua has been developed with extensive real-world testing and feedback. Markua
has been used by Leanpub authors for years, both to create books and massive
open online courses (MOOCs).

Markua's three main contributions are the following:

1. The mapping of Markdown headings (h1, h2, h3, etc.) to book structures
   (parts, chapters, sections, sub-sections, etc.), which provides the ability
   for Markua Processors like Leanpub to produce an ebook from a Markua
   manuscript with one click.
2. The unified resource and attribute list syntax, which lets Markua handle
   audio, code, math and video in the same way that it does images, and which
   supports inline, local and web resource locations.
3. The mapping of book structures to courses, and the creation of a plain-text
   based microformat for course quizzes and exercises, which supports automated
   marking and automated production of everything which is required for a MOOC.

If you have written something (say blog posts or lecture notes) in Markdown, you
can use a Markua Processor, such as Leanpub, to turn them into an ebook or
course with one click. Then, as you go down the path of enhancing the manuscript
and adding things which only make sense in books or courses, this process will
feel like decorating, not converting.

The goal is for writers who are familiar with Markdown to feel that Markdown
somehow grew an understanding of book and course concepts. This goal has also
informed the structure of this specification: instead of writing a separate spec
from scratch, the Markua spec is a fork of the CommonMark spec with the GitHub
Flavored Markdown (GFM) extensions. Everything new in Markua is written as a set
of extensions to CommonMark, and everything in the CommonMark spec after the
introduction is preserved verbatim.

## Why the name "Markua"?

When I set out to specify Markua, I realized I needed a name. I wanted a name
that conveyed the love that I have for Markdown while not implying endorsement
by John Gruber in any way. I also did not want a name which referenced Leanpub:
Markua is a standalone specification with its own identity, which anyone
(including Leanpub competitors) can freely implement. Finally, I was on vacation
in Hawaii when I named Markua, and I wanted something that sounded happy,
friendly and almost Hawaiian. (Yes, I'm aware that there is no r in Hawaiian.)
I also wanted a name that had its .com domain name available, and that was short
and spellable, for branding purposes. The Markua name had all these properties.

## Purpose, structure and attribution of the Markua Spec

The Markua Spec contains a brief introduction to Markua syntax and philosophy
and a formal specification of Markua.

The Markua Spec is based on the GitHub Flavored Markdown (GFM) Spec, which is
based on the CommonMark Spec. The author of the CommonMark Spec is John
MacFarlane.

This Introduction chapter contains a number of introductory sections about
Markua and its relationship to Markdown, CommonMark and GFM.

The remainder of the document is the formal specification of Markua. These
sections are intended to serve as a reference for authors with advanced
questions about Markua syntax and for people implementing Markua processors.

Like GFM, Markua is a strict superset of CommonMark. All the features which are
supported in Markua that are not specified in the original CommonMark Spec are
hence known as **extensions**, and highlighted as such.

The Markua Spec is written in a bit of a strange fashion. Everything after
the Introduction is technically about Markua, but there are three types of
sections:

1. A section written by John MacFarlane about CommonMark
2. A section written by GitHub employees about GFM extensions, modified if
   necessary
3. A section written by Peter Armstrong about Markua

Together, these sections combine to define Markua, since Markua is CommonMark
plus (identical or modified) GFM extensions plus Markua extensions.

To be clear:

* The Introduction sections about CommonMark and GFM were all deleted, except
the "About this document" section, which was heavily modified. The reason for
this approach was that it was too confusing to have introductions to
CommonMark, GFM and Markua in the same document.
* Many of the sections in the Introduction are heavily based on sections in
[The Markua Manual](https://leanpub.com/markua), which is the user guide on how
to write in Markua on Leanpub. (I'm also the author of *The Markua Manual*, so
I'm reusing my own work in this chapter. *The Markua Manual* began life as the
standalone book *The Markua Specification*, and it had its scope reduced when I
decided to base the Markua Spec on the CommonMark Spec.)
* Every section about CommonMark after the Introduction is preserved verbatim.
These sections were written by John MacFarlane.
* The sections about GFM, which are about GFM extensions to CommonMark, are
either preserved verbatim or are modified to reflect the changes made by Markua.
GFM sections which are preserved verbatim have "(GFM extension, identical)" in
their titles. GFM sections which have been modified have "(GFM extension,
modified)" in their titles.
* The sections about Markua in subsequent chapters are organized into
extensions, just as the GFM sections are. These sections all have "(Markua
extension)" in their titles. There are a lot of them!
* The Appendices about Markua are grouped together as Markua Appendices.
* The "A parsing strategy" appendix was written by John MacFarlane about
CommonMark, and like everything after the introduction by John MacFarlane, it is
preserved verbatim.

There are two main benefits of this approach to writing this document.

1. It is abundantly clear whether something that Markua does originates in
   Markdown (as specified by CommonMark), or whether it was added by GFM or
   Markua. This is important for authors, since it will show them what will
   work in other Markdown dialects, and what won't.
2. It means that updating this document as the CommonMark and GFM specs are
   updated will be very easy.

There three main drawbacks, however:

1. It would be nice to see "Markua" everywhere, instead of a combination of
   "Markua" and "CommonMark". For example, the [Characters and lines](#characters-and-lines)
   section starts with a sentence ending "...is a valid CommonMark document."
   It would be less jarring to read "...is a valid Markua document." However,
   this would not preserve what John MacFarlane wrote verbatim, and my judgment
   is that it's more important to keep those sections unchanged than it is to
   make everything say "Markua".
2. Sometimes, what Markua does is not specified fully in one section. So,
   occasionally there are two consecutive sections about essentially the same
   feature, such as "Autolinks" and "Autolinks (GFM extension, identical)".
3. In one case, there is contradictory information. This case is the handling
   of raw HTML tags. CommonMark supports raw HTML, and this is explained in the
   [Raw HTML](#raw-html) section. So, readers who only read that section would
   (incorrectly) think that Markua supported raw HTML. However, GFM then
   disallows some raw HTML tags. Furthermore, Markua then cheekily extends this
   to disallow **ALL** raw HTML except for HTML comments, and explains this in
   the [Disallowed Raw HTML (GFM extension, extended)](#disallowed-raw-html-gfm-extension-extended-)
   section. Thankfully, this is the worst case, and most of the extensions of
   both GFM and Markua to CommonMark are purely additive in nature.

## Modifications to GFM extensions

Note that while Markua is a strict superset of CommonMark, it is not a strict
superset of GFM. Specifically, with respect to the GFM extensions, this is
what Markua does:

### Tables GFM extension

This GFM extension is preserved verbatim. I considered requiring leading and
trailing pipes (`|`), but since GFM tables require a delimiter line, this is
enough to prevent false positives.

### Task list items GFM extension

This GFM extension is removed. Markua is for books and courses, not todo lists.

### Strikethrough GFM extension

This GFM extension is preserved verbatim.

### Autolinks GFM extension

This GFM extension is preserved verbatim. While this extension is neutral for
paper books, ebooks and courses do stand to benefit from this.

### Disallowed Raw HTML GFM extension

As discussed above, this GFM extension originally disallowed a handful of HTML
tags, primarily for security reasons. In Markua, it is extended to disallow
**all** HTML tags except HTML comments. Yes, calling something which removes
part of a feature an "extension" was a bit of a stretch in GFM (it's more of a
reduction), and in this instance, Markua takes this approach and turns it up to
11. `¯\_(ツ)_/¯`

## About this document

A Markua Processor must be able to properly parse a Markua document and output
HTML, as well as any other suitable output formats. For example, the output
formats which Leanpub produces from a single Markua document are: PDF, EPUB,
MOBI, HTML, InDesign and (if applicable) a course with quizzes, exercises and
automated marking.

This document attempts to specify Markua syntax unambiguously. It does not,
however, precisely define all output formats or the content of those output
formats. Instead, the only required output format of a Markua Processor is HTML.
Also, HTML is the only output format where any specification is provided.
The reason that HTML is a required output format for a Markua
Processor to be able to help ensure conformance to the Markua Spec.

This document contains many examples with side-by-side Markua and
HTML.  These are intended to double as conformance tests.  An
accompanying script `spec_tests.py` can be used to run the tests
against any Markua program:

    python test/spec_tests.py --spec spec.txt --program PROGRAM

Since this document describes how Markua is to be parsed into
an abstract syntax tree, it would have made sense to use an abstract
representation of the syntax tree instead of HTML.  But HTML is capable
of representing the structural distinctions we need to make, and the
choice of HTML for the tests makes it possible to run the tests against
an implementation without writing an abstract syntax tree renderer.

Please note that this is not a complete specification of the HTML documents
produced by Markua Processors. It is only a specification of the parts of the
HTML mapping where there is no need to have flexibility on the part of the
Markua Processor. The HTML mapping should be thought of specifying HTML
fragments, not documents. In all of the examples, a Markua Processor may add
more HTML before and after the relevant content. The test is that the HTML
produced contains the specified output, not that it is identical to the
specified output.

This document is generated from a text file, `spec.txt`, written
in Markdown with a small extension for the side-by-side tests. The script
`tools/makespec.py` can be used to convert `spec.txt` into HTML or CommonMark
(which can then be converted into other formats).

In the examples, the `→` character is used to represent tabs.

Every example uses the default Markua document settings, unless otherwise
specified. Any custom settings are specified in a document settings list in the
top of the example.

Finally, Markua does not specify any CSS. However, advice will sometimes be
offered in "CSS Note" sections. This is because certain semantically meaningful
formatting (like strikethrough) is only done in HTML via CSS.

## Handling errors and warnings

Markua is very easy to write in. However, it is possible (especially when
creating a course) to make mistakes.

There are three types of issues which can occur:

1. **Warning:** This is a situation where the author is not making a mistake
   according to the Markua Spec, but the Markua Processor may not be able to do
   what is intended. This includes things like unrecognized or unsupported
   attributes, or Markua features which have not been implemented by the Markua
   Processor. When a Markua Processor encounters content which produces a
   warning, it should format the text block which contains the
   warning-producing content as well as possible.
2. **Error:** This is an error made by the author which should not prevent the
   book or course from being produced. This describes almost every error that
   can be made by an author. This can be as simple as too many consecutive
   asterisks in formatting text, to as complex as bugs with list indentation or
   table formatting. When a Markua Processor encounters an error, it should
   format the text block which contains the error as plain paragraph text.
3. **Fatal Error:** This is an error made by the author which should prevent the
   book or course from being produced. This basically never happens when
   creating a book in Markua, but it can happen when creating a course, if a
   quiz or exercise is invalid. (Since quizzes and exercises can be used by
   Markua Processors such as Leanpub to create MOOCs which students take for
   marks, it's crucial for them to be valid. It would do an author a disservice
   to publish a course with invalid quizzes or exercises.) When a Markua
   Processor encounters a fatal error, it should not generate a book or course
   from the Markua document.

Throughout the Markua Spec, you will encounter the phrases "is a fatal error",
"is an error" or "should produce a warning" to describe these cases.

Whenever a Markua Processor encounters something which is an error (fatal or not)
or should produce a warning, it should also add an error or warning message to a
list of error and warning messages. The content of this message should ideally be
helpful, and indicate the position of the error or warning in the Markua
document, whether it is an error or a warning, and as much information about the
error or warning as is helpful.

The Markua Processor should keep going whenever possible, to continue processing
the remainder of the Markua document. It would be really annoying for authors to
only get one error or warning at a time from a Markua Processor. You want to
find as many errors and warnings as possible.

When a Markua Processor is done processing a Markua document, it should provide
the list of errors and warnings to the author via the appropriate channels. For
a web-based tool, this can be a web page and/or an email message. For a
command-line tool, this can be command-line output and/or an error log file.

Finally, a Markua Processor is NOT allowed to output the list of errors and
warnings in the output format(s) (such as PDF, EPUB, MOBI or HTML) which it is
producing.

## Differences with Markua beta

Markua originated in 2014 (!) as a standalone specification, and evolved for a
number of years in beta before being rewritten in its current form.

As such, there are a number of differences with various versions of the Markua
spec. Frankly, there were a number of cases where the original Markua decision
was better, in isolation. However, at a big picture level, the tradeoff of being
incompatible with CommonMark and GFM was not worth these improvements.

### Newline Changes

Soft line breaks (i.e. single newlines) can now be configured to output a space
(with `soft-breaks: space`), a newline in the HTML source (with
`soft-breaks: source`) or a break tag in HTML (with `soft-breaks: break`).

The default is `source`, for compatibility with Markdown as specified by
CommonMark.

Forced line breaks are done with the two-space hack or the backslash hack, or
by setting the `soft-breaks: break`. The behaviour of the Markua beta was to
always have `soft-breaks: break`. So, if you have a book which was written in
the style of the Markua beta, you will want to set the `soft-breaks: break`
in the document settings.

### List Changes

In the Markua beta, great care was used to construct a syntax for nested lists
which was flexible and powerful, and supported all kinds of indentation styles
and numbering systems.

It was also, however, incompatible with Markdown lists and newline handling.
Specifically, it relied on newlines always being hard breaks. Since this is no
longer true in Markua, the old Markua beta list support (for flat, simple and
complex lists) is no longer supported.

So, what Markua does instead is the following:

1. Use Markdown's list support as specified by CommonMark.
2. Provides a `default-list-numbering` document setting which defines how
   nested numbered lists are output.
3. Provides a `numbering` attribute which can be set on numbered list to
   override this document setting for the particular list.

### Image Changes

The largest breaking change is in how figures, and especially images, are
handled.

Images in the Markua beta were:

```
{alt: "Some alt text"}
![The Figure Caption](url)
```

Images in Markua are now:

```
![Some alt text](url "The Figure Title")
```

This is to bring Markua into compatibility with Markdown and CommonMark.

Also, in the Markua beta, there was support for both a `caption` and a `title`
attribute. The `caption` was typically what was specified, and it was used as
the `title` if no `title` was present. (The caption was the text shown near
the figure; the title was its name in a table of tables or list of figures.)
So, in the Markua beta, you could do this:

```
{alt: "Some alt text", caption: "The Caption", title: "The Title"}
![](url)
```

This was equivalent to this in the Markua beta:

```
{alt: "Some alt text", title: "The Title"}
![The Caption](url)
```

In Markua, there is no more `caption` attribute. The `title` attribute is used
for both the figure caption and the figure name in any table of tables or list
of figures. (So, the `title` is now both the title and the caption.)

So, in Markua, you can do this:

```
{alt: "Some alt text", title: "The Title"}
![](url)
```

This is equivalent to this in Markua:

```
![Some alt text](url "The Figure Title")
```

As an aside, since it's used for both places, it could have been called either
the `title` or the `caption`. The name `title` was chosen, since that is what
HTML attribute is set by CommonMark.

### Figure Changes

While this is the correct decision for images, Markua has generalized the
Markdown image syntax into a syntax for external resources, including code
samples, audio, video, math and tables. So, this change means that all
resources, even those that do not need alt text, end up using that syntax
change.

So, external code samples were:

```
![Hello World](hello.rb)
```

External code samples now are:

```
![](hello.rb "Hello World")
```

This is somewhat unfortunate, but necessary for consistency. Also, if you have
internalized "square brackets = alt text", this is preferable.

### Other Changes

The other breaking changes with the early Markua beta include the following:

* Complex tables have been removed
* Enhanced list support has been removed
* The three-backtick syntax is generalized code fences
* Code fences are for code by default (incl. SVG); to change the type of an
  inline resource in a code fence you must use an attribute list
* Headings now use the Markdown style of Setext and atx headings, as specified
  by CommonMark. Note that unlike previous versions of Markua, with atx headers
  you can use as many # signs after the heading text as you want; trailing `#`
  characters after whitespace are ignored, just as in CommonMark.
* Parts need {class: part} since atx headings are used unchanged, instead of
  relying on the presence of a trailing ` #` to differentiate part and chapter
  headings. On the plus side, Setext chapter headings can get this attribute
  and make parts now.
* Setext headings for sub-sections and below require attribute lists to define
  what they are. (With no attribute list, it's a chapter or section based on the
  delimiter.)
* Indented code blocks from Markdown are now supported, as specified by
  CommonMark.
* Using `===` for page break is no longer supported, since Setext headings were
  restored. Use `{break: page}` instead.

## Differences with Leanpub Flavoured Markdown (LFM)

Besides differences with Markdown in general, Markua also has a number of
specific differences with Leanpub Flavoured Markdown (LFM).

These are the top 9 differences between Markua and LFM:

1. In LFM, parts are created with `-# Part`. In Markua, parts are created an
   attribute list on an atx or Setext heading.
2. In LFM, there is a special syntax for inserting code samples:
   `<<[Optional Title](code/some_code_file.rb)`. In Markua, however, code
   is just a resource, and the LFM syntax is not supported.
3. In LFM, to mark code as added or removed, the magic words were
   `leanpub-start-insert`, `leanpub-end-insert`, `leanpub-start-delete` and
   `leanpub-end-delete`. In Markua, the magic words are `markua-start-insert`,
   `markua-end-insert`, `markua-start-delete` and `markua-end-delete`.
4. In LFM, there is a special syntax for inserting math: `{$$}...{/$$}`. This
   looks nice to people who like LaTeX, and looks like nothing else in
   Markdown. In Markua, however, math is just another resource, and that
   LaTeX-inspired syntax for wrapping math resources is not supported.
5. In LFM, there are `G>` "generic boxes". In Markua, these are replaced with
   blurbs (`B>`).
6. LFM had the `C>` syntax to center text, but we didn't have the same effect on
   generic boxes, and blurbs did not exist. In Markua, a `C>` syntax is just
   syntactic sugar for a centered blurb, for greater consistency. Because of
   this, the blurb also gets the ability to be centered by adding a
   `{class: center}` attribute.
7. LFM had `{rtl}` and `{ltr}` directives. These are not supported in Markua,
   and neither is a `{dir}` attribute in general: any given language is either a
   left-to-right or a right-to-left language, so specifying the language with
   the `lang` document setting and the `{lang: ___}` directive is sufficient.
8. LFM used Sample.txt to define the sample content. Markua moves the definition
   of what constitutes sample content into a `{sample: true}` attribute on
   parts, chapters and sections. So, in Markua, inclusion in the sample is at
   the content level, not the file level. This helps avoid a number of bugs that
   could happen with including at the file level, if a file did not clearly
   break at a chapter boundary. (So, in Leanpub, the Sample.txt approach is not
   supported for books which use Markua.)
9. LFM used Book.txt to define the book content. In Markua, the way that the
   list of manuscript files is defined is considered out of scope of the Markua
   specification itself. (Leanpub still uses the Book.txt approach to specify
   which files are in a book, but other Markua Processors could use other
   approaches.)
10. Using {pagebreak} is no longer supported. Use the `{break: page}` directive
    instead.

Besides these differences, there are a number of smaller ones, which you will
discover if you compare the Markua Spec to the
[Leanpub Flavoured Markdown Manual](https://leanpub.com/leanpubflavouredmarkdownmanual/).

## A Note for Leanpub authors

If you're a Leanpub author writing in Markua, this is **NOT** what you should be
reading. Leanpub's current Markua implementation was based on an earlier beta of
the Markua spec.

Leanpub authors should read [The Markua Manual](https://leanpub.com/markua/read)
to learn how to write in Markua on Leanpub today.

The Markua Manual recommends the way to write using Leanpub's current Markua
support which is most compatible with the version of Markua described in this
spec.

## Acknowledgments

I ([Peter Armstrong](https://twitter.com/peterarmstrong)) am the creator of
Markua, but I'm getting lots of help, especially from my Leanpub cofounders
[Scott Patten](https://twitter.com/scott_patten), [Len Epp](https://twitter.com/lenepp)
and [Braden Simpson](https://twitter.com/bradensimpson). Scott is the lead
developer of Leanpub's book generation engine (both the LFM and Markua versions),
and he has given me both the most and the best feedback about Markua over the
years that I've been working on it.

Perhaps most important, Markua is built on Markdown. So, Markua literally would
not exist without John Gruber and Aaron Swartz. Markua is now also using the
CommonMark spec as its starting point, so I am really grateful to John MacFarlane
(the author of the CommonMark spec) and the team behind CommonMark and `cmark`.
I'm also really grateful to GitHub for adopting Markdown, for basing the GitHub
Flavored Markdown spec on the CommonMark spec, and for their work on `cmark-gfm`.

Markua is also benefitting from years of feedback about Leanpub Flavoured
Markdown and Markua, from many incredibly helpful and patient Leanpub authors.
If it wasn't for these authors, there would be no Leanpub, and no Markua.

I'd also like to thank my father, who read some of the very early manuscripts
when this was a standalone spec and gave me feedback.

Finally, I would like to thank my wife Caroline and my son Evan: while this is
not as long as my other books, a lot of thought and effort went into it, and a
lot of sacrifice. Thanks very much.
