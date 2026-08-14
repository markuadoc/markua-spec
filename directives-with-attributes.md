# Directives with Attributes

**Status:** Decided and applied — the spec changes landed in PR #33 (commit
`fd273eb`), and the formerly-open questions at the end now carry their
answers as applied
**Date:** August 14, 2026
**Context:** Grew out of the audio narration proposal (PR #32 → PR #33) and a
design discussion between Peter and Claude about whether the `lang-*` /
`audio-voice-*` hyphenated directive families are the right mechanism. PR #33
now carries both this proposal and its application to spec.txt.

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

**Adopted as a hard rule:** attribute keys may not begin with `default-`.
This one reservation makes the toggle family's flagging guaranteed rather
than conventional, at no cost — a `default-*` key has no meaning attached to
a block or span anyway. (Applied in the Attribute Keys section of the spec.)

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

*Decided: the keyword is `pause`, not `audio-pause` — see the answered
questions below.*

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
  underscores — no digits, per the PR #33 revert). The one addition is the
  `default-` prefix reservation described above.
* From PR #33's audio section: the `audio` attribute (delivery directions),
  the `audio-emphasis` attribute and `default-audio-emphasis` setting, named
  voices, and the format-invisibility rule.

## Spec sections amended (applied in commit `fd273eb`)

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

## The open questions, answered

These were open when this proposal was written. The answers below are what
the applied spec text now says, with the reasoning for each.

1. **Explicit pause durations: include them.** `{pause: 2s}` costs the
   grammar nothing (the duration sits in value position), resolves #32's
   named-vs-parameterized question with "both", and spares an author who
   needs one ten-second silence from redefining `audio-pause-long` for the
   whole book. The named values remain the recommended spellings, since
   they stay tunable from the settings.
2. **The pause keyword is `pause`, not `audio-pause`.** A directive is read
   at the point of prose, where `{pause: long}` reads as the stage
   direction it is; the `audio-` grouping earns its keep in the settings
   block (`audio-pause-long`), which is written once and scanned as a
   group. And the section's format-invisibility rule already guarantees a
   pause cannot mean anything in visual output, so the keyword does not
   need a prefix to say so.
3. **`default-lang`, with `lang` accepted as an alias.** The rename
   completes the pattern (attribute `x` marks an element; `default-x` sets
   the ambient default). The alias stays because the spec never marked the
   `lang` setting unsupported — unlike the `lang-*` directives — so shipped
   books may be using it, and the alias costs one line of processor
   behavior. Drop it only if Leanpub confirms the setting was never honored
   in production.
4. **The `default-` reservation is a hard rule, not a convention.** The
   entire error-detection design rests on it: one future extension
   attribute named `default-anything` would silently break the warning
   behavior of every toggle. A convention that must never be violated is a
   rule. It costs nothing today — no existing attribute key begins with
   `default-`.
5. **All `default-*` settings may be restated mid-document, not an
   enumerated subset.** One rule, no list to maintain: anything named
   `default-*` is by construction "the value used when nothing more
   specific applies", which is always coherent to change mid-flow (a
   polyglot programming book genuinely wants
   `{default-code-language: python}` at a chapter boundary). An enumerated
   subset would reintroduce a registry and make the general rule not
   general.
6. **Multi-pair floating lists stay an error.** A toggle is the thing an
   author hunts for when debugging "why is the rest of my book Japanese?" —
   one line, one instruction keeps toggles scannable, and the settings
   block keeps its clean positional identity as the only multi-pair
   floating list. This is also the forward-compatible choice: relaxing an
   error into a multi-toggle later breaks nothing, while the reverse would
   break existing documents.

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
