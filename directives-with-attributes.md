# Directives with Attributes

**Status:** Decided and applied in PR #33. The final syntax — bareword
directives with an optional argument: `{pause long}`, `{default lang: jpn}`
— supersedes the earlier colon spellings (`{pause: long}`,
`{default-lang: jpn}`) and is applied throughout the spec. The
formerly-open questions at the end carry their answers as applied
**Date:** August 14, 2026
**Context:** Grew out of the audio narration proposal (PR #32 → PR #33) and a
design discussion between Peter and Claude about whether the `lang-*` /
`audio-voice-*` hyphenated directive families are the right mechanism. PR #33
now carries both this proposal and its application to spec.txt.

---

## The decision

1. **A directive is a bare keyword followed by an optional argument**, on a
   line by itself with a blank line above and below it. The argument is
   either a bare value or an ordinary comma-separated attribute list:

   ~~~
   {pagebreak}
   {pause short}
   {default lang: jpn}
   {default lang: jpn, audio-voice: kenji}
   ~~~

2. **The leading bareword classifies by shape.** An attribute list is
   exclusively `key: value` pairs, so its first token always carries a
   colon; a directive's first token never does. Any curly-brace line is
   classifiable from its characters alone, whatever the whitespace around
   it. The blank lines remain required style, warnable when missing, but a
   formatting mistake never changes what a line means.
3. **Directive keywords are kept distinct from attribute keys as a design
   practice** — there is no `pause` attribute, and no attribute is named
   `default`. Nothing is formally reserved: shape does the classifying on
   its own, and every mistake still has exactly one plausible reading and
   gets flagged — an unknown directive keyword warns, a jammed directive
   still parses as a directive, and a floated attribute list is an error
   with a suggested fix.
4. **There is exactly one toggle keyword: `default`.** Each `key: value`
   pair in its argument restates the document setting named `default-` +
   key, from that point until that setting's next restatement:
   `{default lang: jpn}` restates `default-lang`. The pair inside the toggle
   is the same pair the author would attach to one block — `{lang: jpn}`
   marks a paragraph; `{default lang: jpn}` changes the book. Several pairs
   toggle together when the change is one event. This replaces the
   hyphenated directive families (`lang-*`, `audio-voice-*`), which were
   parameterized directives with the parameter smuggled into the keyword —
   the workaround that existed only because directives could not take
   arguments.

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
carry an argument. `default` is one directive among them, not a fourth
thing: `{default lang: jpn}` restates the `default-lang` document setting by
name, wrapping the same `lang: jpn` pair the author would otherwise attach
to a single block.

## Directive shapes

* **Actions** — one-shot, at a point: a bare keyword with an optional bare
  value. `{pagebreak}`, `{toc}`, `{pause}`, `{pause long}`, `{pause 2s}`.
* **Toggles** — sticky, until the next restatement: the `default` keyword
  with an attribute list. `{default lang: jpn}`,
  `{default audio-voice: james}`, `{default audio-emphasis: none}`,
  `{default lang: jpn, audio-voice: kenji}`.

The toggle's attribute list is an ordinary one: comma-separated, values
quoted or unquoted per the normal rules. The commas are load-bearing, not
style — an unquoted attribute value may contain spaces, and the comma is
what terminates it, so space-separated pairs would be ambiguous. A
multi-pair toggle behaves exactly like the single-pair toggles in sequence:
each pair restates its own setting, each setting reverts independently at
its own next restatement, an unrecognized key warns while the rest apply,
and duplicate keys follow the first-wins-with-warning attribute rule. A
bare `{default}` with no argument is an error.

A floating attribute list with no leading keyword remains invalid everywhere
except as the document settings block at the start of the document.

## Error handling: what gets flagged

Shape does the work — nothing needs to be reserved:

| What the processor sees | What it does |
|---|---|
| Directive shape (leading bareword), known keyword | Executes it |
| Directive shape, unknown keyword (a typo like `{pauze short}`) | **Warning: unknown directive.** A directive is never silently ignored |
| A `default` toggle containing a key with no matching `default-*` setting | **Warning for that pair**; the remaining pairs still apply |
| A directive jammed against a block (`{pause long}` or `{pagebreak}` with no blank line) | Not a valid attribute list, so parsed as a directive anyway, with a formatting warning — no keyword registry needed |
| An attribute list floated with blank lines (`{lang: jpn}` detached from its block) | **Error**, with the fix suggested: attach it, or write `{default lang: jpn}`. (Exception: the settings block at the start of the document) |
| Attached attribute list with unknown keys | Silently filtered — the existing extension-attributes behavior, unchanged |

**Reversed after the bareword syntax landed: nothing is reserved.** Under
the earlier colon spellings the reservation was load-bearing; with the
leading bareword, shape alone classifies (`{default: foo}` is an attribute
list, `{default lang: jpn}` is a directive), so the reservation guarded
nothing mechanical. Naming an attribute `default` or `default-something` is
legal but unwise, and the spec now says exactly that — an advisory note in
the Attribute Keys section, not an error.

## Concrete changes

### Pauses: three directives collapse into one

Replace `{audio-pause}`, `{audio-pause-short}` and `{audio-pause-long}` with
a single action whose argument is a bare value:

```
{pause}                 a standard beat        (default 1.5s)
{pause short}           a breath               (default 0.5s)
{pause long}            a scene-change silence (default 3s)
{pause 2s}              an explicit duration
```

The three named durations remain configurable via the existing
`audio-pause`, `audio-pause-short` and `audio-pause-long` document settings.
The explicit-duration form resolves PR #32's open question 1 (named vs.
parameterized pauses): both, through one directive.

*Decided: the keyword is `pause`, not `audio-pause` — see the answered
questions below.*

### Language: `{default lang: jpn}` replaces the `lang-*` family

```
{default lang: jpn}

...five or ten pages of Japanese...

{default lang: eng}
```

* The code sits in value position, where uppercase is legal — so
  `{default lang: zh-Hant}` is simply correct, dissolving the latent
  `{lang-zh-Hant}` rule violation that PR #32 flagged.
* The `lang` document setting is renamed `default-lang`, with `lang` kept as
  a documented alias; the toggle restates the setting by name.
* The `lang-*` directive family is **renamed without apology** — no legacy
  alias, no deprecation note. The spec's own text (spec.txt:2811) says the
  `lang-*` directives are not yet supported on Leanpub, so no author should
  have been relying on the old spelling. **Decided.**
* The `lang` *attribute* on spans and blocks is unchanged: it remains the
  exception mechanism for a single element.

### Voices: names in the manuscript, casting on the platform

* Toggle: `{default audio-voice: james}` … `{default audio-voice: narrator}`,
  restating the `default-audio-voice` document setting. A voice change that
  coincides with a language change is one directive:
  `{default lang: jpn, audio-voice: kenji}`.
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
may be restated through the `default` toggle, taking effect from that point
— gives the rest of the family mid-document toggling with zero new
mechanism:

```
{default audio-emphasis: none}     emphasis stops being narrated from here
{default code-language: python}    code blocks default to Python from here
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
  underscores — no digits, per the PR #33 revert). The only addition is an
  advisory note that `default`-flavored attribute names are unwise.
* From PR #33's audio section: the `audio` attribute (delivery directions),
  the `audio-emphasis` attribute and `default-audio-emphasis` setting, named
  voices, and the format-invisibility rule.

## Spec sections amended (applied in PR #33)

1. **Directives (M)** — new definition: bare keyword plus optional argument
   (bare value or attribute list), on its own line with blank lines around
   it; the two kinds (actions, the `default` toggle); shape-based
   classification; the error-handling table above.
2. **Attribute list format → the three insertion ways** — way 3 currently
   reads "the attribute list contains directives"; rewrite to point at the
   new Directives definition.
3. **Extension attributes** — remove the "free-floating directives" phrase;
   silent filtering applies to *attached* lists only; floating unknowns warn.
   (This resolves the existing internal contradiction between these three
   passages.)
4. **Attribute Keys** — the reservation was ultimately dropped; an advisory
   note that `default`-flavored attribute names are unwise replaces it.
5. **The lang section** — replace `lang-*` with `{default lang: xxx}`;
   rename/alias the setting; fix the `zh-Hant` example.
6. **The audio narration section (PR #33)** — collapse the pause directives
   to `{pause}`; replace `audio-voice-*` with `{default audio-voice: name}`;
   drop the `audio-voice-<name>` voice-definition settings (casting is
   platform configuration); add the reserved `author` voice alongside
   `narrator`; delete the disambiguation prose; update the directives-list
   stub.
7. **The standard document settings** — state the general `default-*`
   restatement rule (or the enumerated list).

## The open questions, answered

These were open when this proposal was written. The answers below are what
the applied spec text now says, with the reasoning for each.

1. **Explicit pause durations: include them.** `{pause 2s}` costs the
   grammar nothing (the duration is the directive's argument), resolves #32's
   named-vs-parameterized question with "both", and spares an author who
   needs one ten-second silence from redefining `audio-pause-long` for the
   whole book. The named values remain the recommended spellings, since
   they stay tunable from the settings.
2. **The pause keyword is `pause`, not `audio-pause`.** A directive is read
   at the point of prose, where `{pause long}` reads as the stage
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
4. **The `default-` reservation: answered "hard rule", then dropped.**
   Under the colon spellings (`{default-lang: jpn}`), the reservation was
   load-bearing — the error-detection design rested on it — and the answer
   was a hard rule. The final bareword syntax classifies by shape alone, so
   the reservation guards nothing mechanical, and it is dropped: naming an
   attribute `default` or `default-something` is legal but unwise, and the
   spec carries an advisory note saying so rather than an error.
5. **All `default-*` settings may be restated mid-document, not an
   enumerated subset.** One rule, no list to maintain: anything named
   `default-*` is by construction "the value used when nothing more
   specific applies", which is always coherent to change mid-flow (a
   polyglot programming book genuinely wants
   `{default code-language: python}` at a chapter boundary). An enumerated
   subset would reintroduce a registry and make the general rule not
   general.
6. **Multi-pair toggles are allowed; bare multi-pair floating lists stay an
   error.** (Revised from the original answer, which predated the bareword
   syntax.) The original rule defended against a bare floating list
   ambiguous with the settings block; with the leading `default` keyword
   that ambiguity is gone, so
   `{default lang: jpn, audio-voice: kenji}` — one scene switch, one
   directive — is legal, comma-separated, with per-pair semantics. What
   remains an error is a floating attribute list with no leading keyword,
   anywhere except as the settings block at the top of the document.

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
* **The final form came last.** Directives began as `{keyword}` only,
  briefly became `{pause: long}` / `{default-lang: jpn}`, and settled as
  bareword + argument — `{pause long}`, `{default lang: jpn}` — once it was
  clear the leading bareword makes directives recognizable by shape alone
  (no keyword registry needed for classification) and collapses every
  toggle into one `default` verb wrapping the attribute pair the author
  already knows. Multi-pair toggles follow, comma-separated because
  unquoted attribute values may contain spaces and the comma is what
  terminates them.
