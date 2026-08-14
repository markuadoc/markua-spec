# Markua Proposal: Audio Narration Markup

**Status:** Proposal (draft for discussion) · **Target:** Markua 0.30+ · **From:** Leanpub AudiobookAI team · **Date:** 2026-08-14

## Motivation

Markua already turns one manuscript into every format a reader *reads* — PDF, EPUB, web. Audiobooks are becoming a first-class output format (Leanpub's AudiobookAI narrates Markua manuscripts today), but the manuscript currently has no way to express *how it should be read aloud*. Narration intent lives outside the document — in platform settings and AI inference — which means it isn't portable, isn't versioned with the text, and can't vary within a book.

This proposal adds a small, semantic, **format-invisible** narration layer to Markua: pauses, delivery direction, speaker changes, and the document settings that control them. A Markua document with narration markup renders **byte-identically** in every non-audio format as the same document without it.

## Design principles

1. **Invisible everywhere but audio.** Every construct here produces *nothing* in PDF/EPUB/web output. Spans render their text; directives render nothing.
2. **Semantic, not phonetic.** Authors say *what they mean* ("sarcastic", "a long pause", "voice one"); the audio processor decides how the engine achieves it. No SSML, no engine-specific tags in the manuscript.
3. **Settings-driven.** Anything tunable (pause lengths, what "voice one" is) is a document setting with a sensible default, mirroring the platform's audiobook generation settings.
4. **Degrade gracefully.** A processor that doesn't understand audio markup must be able to ignore it without changing the readable output.

---

## 1. Pause directives

Three one-shot directives (the `{pagebreak}` class: effect happens once, at that point, nothing sticky), each on its own line with blank lines around it:

```
The sentence before the beat.

{a_pause}

The sentence after it.

{a_short_pause}

{a_long_pause}
```

- `{a_pause}` — a standard beat. Default **1.5s**.
- `{a_short_pause}` — a breath. Default **0.5s**.
- `{a_long_pause}` — a scene-change silence. Default **3s**.

Durations are controlled by document settings (§5). In every non-audio format, all three render as nothing (not even vertical space).

> **Alternative considered:** a single parameterized directive — `{pause}`, `{pause: short}`, `{pause: long}`, `{pause: 2.5s}` — is more spec-economical (one directive, one namespace entry) and permits exact durations. The three named directives above are proposed as primary because they read as prose stage directions; the parameterized form could be admitted alongside them or instead of them. Spec owner's call.

## 2. Inline delivery direction: the `audio` attribute

Markua already has attributed spans (`[text]{key: value}`). This proposal defines one new span attribute, `audio`, whose value is a comma-separated list of free-form delivery directions applying to the span's text:

```
[Well. That went brilliantly.]{audio: "drawn out, sarcastic"}

She left without a word. [Typical.]{audio: whispered}
```

- The vocabulary is deliberately **open** ("sarcastic", "drawn out", "whispered", "excited", "deadpan", …). The audio processor maps directions to whatever its engine supports (e.g., expressive TTS performance tags) and ignores what it can't express.
- Typical usage is a span over the sentence or clause being directed, commonly at the end of a paragraph's sentence as written.
- In non-audio formats the span renders as its plain text; the attribute produces nothing.

## 3. A note on emphasis

Markua's existing emphasis is already narration markup and needs no new syntax: audio processors SHOULD read `*italic*` as mild spoken stress and `**bold**` as strong spoken stress, exactly as a human narrator treats emphasized text. An author who wants emphasized-looking text spoken flat can opt out per span: `[**READ THE MANUAL**]{audio: flat}`. This proposal standardizes that default mapping rather than inventing a parallel emphasis system.

## 4. Speaker / voice changes

Books with dialogue, interviews, or multiple narrators need more than one voice. Voices are **named slots** (`narrator`, `one`, `two`, …) defined in document settings (§5), and the mechanism deliberately mirrors Markua's **language** mechanism tier for tier — the spec's proven pattern for "a document-wide default, temporarily overridable, with a sticky switch":

**Tier 1 — the `voice` document setting** (the default, like `lang: eng`):

```
{
  voice: narrator
}
```

The document's default speaker. Its default value is `narrator`, so the setting is usually omitted.

**Tier 2 — the `voice` attribute** on a span or block (a temporary override that **reverts immediately after**, like `[bonjour]{lang: fra}`):

```
The interviewer leaned in. ["But why Markua?"]{voice: one} It was a fair question.

{voice: two}
This whole paragraph is read by voice two, and the next paragraph
reverts to the ambient voice on its own — nothing to reset.
```

**Tier 3 — the `voice-*` directive family** (a sticky new default that persists **until the next `voice-*`**, like `{lang-fra}` … `{lang-eng}`):

```
{voice-one}

Everything from here is read by voice one — whole sections or chapters.

{voice-narrator}

And now we are back to the book's narrator.
```

The hyphenated directive spelling is load-bearing, exactly as it is for `lang-*`: a sticky switch line can never be mistaken for an attribute list attaching to the following block, because `{voice-one}` and `{voice: one}` are different spellings with different scoping by construction. An unrecognized slot name resolves to `narrator` and warns — the same fallback rule as an unrecognized language code. In non-audio formats, all three tiers produce nothing beyond the spans' own text.

## 5. Document settings

All narration tunables live in the document settings hash (the `{ key: value, … }` block at the start of the document), under an `audio-` prefix, mirroring what a platform's audiobook generation settings can control:

```
{
  voice: narrator,
  audio-pause: 1.5s,
  audio-pause-short: 0.5s,
  audio-pause-long: 3s,
  audio-voice-narrator: nova,
  audio-voice-one: "James (interviewer)",
  audio-voice-two: sage,
  audio-speed: 1.0,
  audio-emphasis: spoken
}
```

- `voice` — the document's default speaker slot (§4 tier 1), mirroring `lang`'s role as a document setting. Default `narrator`.

- `audio-pause`, `audio-pause-short`, `audio-pause-long` — durations for §1's directives (seconds; `s` suffix optional).
- `audio-voice-narrator`, `audio-voice-one`, `audio-voice-two`, … — what each slot resolves to. Values are platform-interpreted voice identifiers or labels (a platform voice name, a voice id, an author's own cloned voice — the spec does not constrain the value's meaning, only the slot mechanism).
- `audio-speed` — default narration rate multiplier.
- `audio-emphasis` — `spoken` (default, §3's mapping) or `flat` (document-wide opt-out).
- The set is open-ended by design: platforms may honor additional `audio-*` settings corresponding to their generation options (model, expressiveness/stability, chapter/section boundary pauses, …), following Markua's existing custom-settings permissiveness.

**Precedence (proposed, open for discussion):** platform defaults < platform per-book generation settings < document settings — the manuscript is the portable, versioned source of truth for narration intent, with the platform UI as the fallback for anything the document doesn't say. The reverse ordering (platform overrides document) is defensible and flagged as an open question.

## 6. Compatibility

- **Non-audio processors and older versions:** spans render their text (existing Markua behavior for unknown span attributes); the `audio` and `voice` attributes are ignored wherever they appear — including `{voice: one}` block-attribute lines, which attach to their following block exactly like any block attribute and simply carry a name a non-audio renderer doesn't use. The bare *directive* families (`{a_pause}`, `{a_short_pause}`, `{a_long_pause}`, `{voice-*}`) require processors to treat unknown standalone directives as no-ops rather than attaching them to the following block — the hyphenated `voice-*` spelling exists precisely so this class is syntactically distinguishable (the `lang-*` precedent). Current-processor behavior for unknown bare directives should be verified; this proposal makes no-op the required behavior for conforming processors.
- **Sample semantics, sections, and every existing attribute** (`{sample:}`, `{full:}`, `{class: part}` …) are unaffected; `audio` and `voice` are additive names in the attribute namespace.
- **Diffability:** all constructs are plain text in the manuscript, so version control, review, and incremental audiobook regeneration (diffing narration input across edits) see them like any other prose change.

## 7. Implementation notes (Leanpub, non-normative)

Leanpub's AudiobookAI pipeline already contains the machinery each construct maps onto: configurable pause blocks materialized as real silence at assembly (with author-set chapter/section pause presets of 0.5–5s), expressive delivery via engine performance tags, per-sentence/word-timed synced transcripts (narration markup would be stripped from display text exactly as engine tags are today), and document-level generation settings. Named voice slots align with an open multi-voice investigation. Estimated implementation surface: parser attribute/directive recognition, speech-plan pause/voice/delivery block emission, settings bridge, and display-text exclusion — no changes to non-audio renderers beyond ignoring the new names.

## Open questions

1. Named pause directives (`{a_pause}` family) vs. parameterized (`{pause: …}`) vs. both.
2. Settings precedence: document over platform, or platform over document (§5).
3. Should `audio` direction values be an open vocabulary (proposed) or a spec-enumerated list with an escape hatch?
4. Sticky `{voice-*}` scope: the `lang-*` precedent is truly document-sticky (until the next directive), and §4 follows it; if a forgotten reset re-voicing the rest of a book proves to be a real authoring hazard, an end-of-chapter auto-reset would be the deviation from precedent to consider.
5. Slot declaration: §4 resolves unknown slots to `narrator` with a warning (the `lang` fallback rule); should processors additionally require slots to be defined in settings before use?
