# Directives with Attributes

**Status:** Proposal — agreed in discussion, not yet applied to spec.txt
**Date:** August 14, 2026
**Context:** Grew out of the audio narration proposal (PR #32 → PR #33) and a
design discussion between Peter and Claude about whether the `lang-*` /
`audio-voice-*` hyphenated directive families are the right mechanism.
Supersedes parts of PR #33 once applied.

---

## The decision

1. **A directive is defined by its position:** a single attribute list on a
   line by itself, with a blank line above and below it. Position, not
   lexical shape, is what classifies it.
2. **Directives may carry attributes.** A directive is a keyword, optionally
   with a value: `{pagebreak}`, `{pause: long}`, `{default-lang: jpn}`.
3. **Directive keywords are kept distinct from attribute keys** as a design
   practice — not a grammar law. Because the keyword vocabularies don't
   overlap, a line that is not a valid directive can be recognized and
   flagged as such, and a line that is not a valid attribute list can be
   recognized and flagged as such. Whitespace mistakes become warnings
   instead of silent reinterpretations.
4. **Toggling a default is a directive named after the setting it toggles:**
   `{default-lang: jpn}` mid-document changes the `default-lang` setting from
   that point forward, until the next such directive. This replaces the
   hyphenated directive families (`lang-*`, `audio-voice-*`), which were
   parameterized directives with the parameter smuggled into the keyword —
   the workaround that existed only because directives could not take values.

The unifying principle, which the spec can teach in one sentence:
**position is scope.**

| Where the attribute list sits | What it is | Scope |
|---|---|---|
| Top of the document | Document settings | The whole document |
| On its own line, blank lines above and below | **Directive** | From this point on (toggles), or at this point (actions) |
| Immediately above a block (one newline, no blank line) | Block attribute list | That block |
| Immediately after a span (no space) | Span attribute list | That span |

The closer you attach it, the smaller its reach.

## The zoo stays at three animals

This proposal adds no new construct. Document settings, attribute lists, and
directives remain the full inventory; directives simply gain the ability to
carry a value. The `default-` names are a *convention within directives*, not
a fourth thing: `{default-lang: jpn}` is a directive whose name happens to
match the document setting it toggles — the same deliberate name-sharing the
audio proposal already uses between voice directives and voice settings.

## Directive shapes

Two shapes, one form each:

* **Actions** — one-shot, at a point: a bare keyword, optionally
  parameterized. `{pagebreak}`, `{toc}`, `{pause}`, `{pause: long}`.
* **Toggles** — sticky, until the next one: a `default-*` keyword with a
  value. `{default-lang: jpn}`, `{default-audio-voice: james}`,
  `{default-audio-emphasis: none}`.

A directive contains at most one key-value pair. (The multi-pair floating
list remains reserved for the document settings block at the top of the
document; a multi-pair list elsewhere is an error. This restriction can be
relaxed later if a need appears.)

## Error handling: what gets flagged

The distinct-keywords practice is what makes every common mistake detectable:

| What the processor sees | What it does |
|---|---|
| Floating line, known directive keyword | Executes it |
| Floating line, unknown keyword (e.g. a typo `{pauze: long}`, or a stray block attribute `{lang: jpn}`) | **Warning: unknown directive.** The floating position is never a silent discard zone |
| Attached attribute list containing a directive-only keyword (e.g. `{pause: long}` jammed against a paragraph) | **Warning: this looks like a directive missing its blank lines** |
| Attached attribute list with unknown keys | Silently filtered — the existing extension-attributes behavior, unchanged |
| Bare keyword jammed against a block (`{pagebreak}` with no blank line) | Parsed as a directive anyway, with a formatting warning — today's leniency survives, because a bare keyword cannot be a valid attribute list |

**Recommended hard rule:** attribute keys may not begin with `default-`.
This one reservation makes the toggle family's flagging guaranteed rather
than conventional, at no cost — a `default-*` key has no meaning attached to
a block or span anyway.

## Concrete changes

### Pauses: three directives collapse into one

Replace `{audio-pause}`, `{audio-pause-short}` and `{audio-pause-long}` (PR
#33's current spelling) with a single parameterized action:

```
{pause}                 a standard beat        (default 1.5s)
{pause: short}          a breath               (default 0.5s)
{pause: long}           a scene-change silence (default 3s)
{pause: 2s}             an explicit duration
```

The three named durations remain configurable via the existing
`audio-pause`, `audio-pause-short` and `audio-pause-long` document settings.
The explicit-duration form resolves PR #32's open question 1 (named vs.
parameterized pauses): both, through one directive.

*Alternative if the `audio` grouping should be visible at the point of use:
`{audio-pause: long}` — same mechanics, longer keyword.*

### Language: `{default-lang: jpn}` replaces the `lang-*` family

```
{default-lang: jpn}

...five or ten pages of Japanese...

{default-lang: en}
```

* The value sits in value position, where uppercase is legal — so
  `{default-lang: zh-Hant}` is simply correct, dissolving the latent
  `{lang-zh-Hant}` rule violation that PR #32 flagged.
* The `lang` document setting is renamed `default-lang`, with `lang` kept as
  a documented alias, so the directive and the setting share one name.
* The `lang-*` directive family is **renamed without apology** — no legacy
  alias, no deprecation note. The spec's own text (spec.txt:2811) says the
  `lang-*` directives are not yet supported on Leanpub, so no author should
  have been relying on the old spelling. **Decided.**
* The `lang` *attribute* on spans and blocks is unchanged: it remains the
  exception mechanism for a single element.

### Voices: names in the manuscript, casting on the platform

* Toggle: `{default-audio-voice: james}` … `{default-audio-voice: narrator}`.
  The directive is literally named after the `default-audio-voice` document
  setting it toggles — the name-sharing becomes exact.
* The `audio-voice` attribute on spans and blocks is unchanged:
  `["But why Markua?"]{audio-voice: james}`.
* **Casting moves out of the manuscript. Decided.** The
  `audio-voice-james: onyx` voice-definition settings are dropped from the
  spec. The manuscript names the voices; which actual voice performs each
  name is platform configuration, defined outside the scope of the Markua
  spec (for Leanpub, the audiobook settings). Platforms draw on their own
  set of built-in voices, voice identifiers, and authors' recorded or
  cloned voices. (A platform may still accept in-document bindings through
  its own custom document settings under the existing custom-settings
  rules; the spec mandates no syntax for it.)
* **Two reserved names**, both resolved by the platform:
  * `narrator` — the voice used as the primary narrator of the book; the
    default voice.
  * `author` — the voice used as the author voice of the book. Reserved
    separately so a book can cast a stock voice as its narrator while the
    author speaks as themselves: for example, a female stock narrator with
    the author's own male voice — recorded or cloned — for author asides,
    or any other combination.
* Fallback rules: a voice name with no platform casting resolves to
  `narrator`, with a warning. An uncast `author` resolves to `narrator`
  silently — the author simply has not chosen a distinct author voice.
* Because names no longer appear in setting keys, the attribute-key
  character rules no longer constrain them mechanically. Names should
  remain simple lowercase words as a convention (the reserved names are
  lowercase), and matching is exact.
* The `audio-voice-*` directive family and its hyphenation-disambiguation
  prose are deleted from the audio section.

### The free bonus: every `default-*` setting becomes toggleable

The general rule — any document setting whose name begins with `default-`
may be restated as a directive, taking effect from that point — gives the
rest of the family mid-document toggling with zero new mechanism:

```
{default-audio-emphasis: none}     emphasis stops being narrated from here
{default-code-language: python}    code blocks default to Python from here
```

Whether *all* `default-*` settings should accept this, or an enumerated
subset, is an open question below.

## What does not change

* Span attribute lists and block attribute lists: syntax, scoping,
  extension-attribute filtering.
* The document settings block at the top of the document.
* All existing bare-keyword directives: `{pagebreak}`, `{mainmatter}`,
  `{backmatter}`, the insertion directives, `{begin-hanging-paragraphs}` /
  `{end-hanging-paragraphs}`.
* The Attribute Keys character rules (lowercase letters, hyphens,
  underscores — no digits, per the PR #33 revert).
* From PR #33's audio section: the `audio` attribute (delivery directions),
  the `audio-emphasis` attribute and `default-audio-emphasis` setting, named
  voices, and the format-invisibility rule.

## Spec sections to amend (when we apply this)

1. **Directives (M)** — new definition: position-based (blank lines above
   and below); directives may carry one value; the two shapes (actions,
   `default-*` toggles); keyword-distinctness practice; the error-handling
   table above; revise the "poorly-formatted directive" leniency clause to
   the bare-keyword case.
2. **Attribute list format → the three insertion ways** — way 3 currently
   reads "the attribute list contains directives"; rewrite to point at the
   new Directives definition.
3. **Extension attributes** — remove the "free-floating directives" phrase;
   silent filtering applies to *attached* lists only; floating unknowns warn.
   (This resolves the existing internal contradiction between these three
   passages.)
4. **Attribute Keys** — add the reserved `default-` prefix rule, if adopted.
5. **The lang section** — replace `lang-*` with `{default-lang: xxx}`;
   rename/alias the setting; fix the `zh-Hant` example.
6. **The audio narration section (PR #33)** — collapse the pause directives
   to `{pause}`; replace `audio-voice-*` with `{default-audio-voice: name}`;
   drop the `audio-voice-<name>` voice-definition settings (casting is
   platform configuration); add the reserved `author` voice alongside
   `narrator`; delete the disambiguation prose; update the directives-list
   stub.
7. **The standard document settings** — state the general `default-*`
   restatement rule (or the enumerated list).

## Open questions

1. Explicit pause durations (`{pause: 2s}`): include now, or named values
   only?
2. Pause keyword: `pause` or `audio-pause`?
3. The `lang` document *setting*: recommended rename to `default-lang`, to
   complete the pattern (attribute `x` marks an element; setting/directive
   `default-x` sets the ambient default). Remaining sub-question: whether
   `lang` stays accepted as a one-line alias — yes only if the setting is
   honored in production today. (The `lang-*` *directives* are decided:
   renamed without apology.)
4. The reserved `default-` prefix in attribute keys: hard rule (recommended)
   or convention only?
5. Mid-document restatement: all `default-*` settings, or an enumerated
   subset?
6. Multi-pair floating lists: keep as an error, or define as a multi-toggle?

## How we got here (the short version)

* **Hyphenated families are a workaround.** `{lang-jpn}` is one operation
  ("set the default language") wearing hundreds of keyword names, because
  directives couldn't take values. The costume is what caused the digits
  amendment (since reverted), the `zh-Hant` uppercase violation, and the
  lowercase-`james` rule.
* **Dual-use `{lang: jpn}` was considered and rejected.** Letting the same
  spelling mean "this block" when attached and "from here on" when floating
  is formally unambiguous but converts the most common authoring mistake — a
  blank line added or removed — into a valid document that silently means
  something else, in both directions, with no possible warning. Today that
  same mistake is a reported error; we keep it detectable.
* **A "mid-document settings list" framing was considered and rejected** as
  a fourth animal in the zoo — part settings, part attribute list, part
  directive. The three-animal framing (directives gain attributes) says the
  same thing with one sentence instead of a new concept.
* **The synthesis:** blank lines classify; distinct keywords make mistakes
  flaggable; `default-*` names the toggles after the settings they toggle.
