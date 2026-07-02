---
name: run-translation-review
description: >-
  Run an automated review of a translated RLadies+ website page (Spanish,
  Portuguese, or French) against its English source, as a pre-human-review gate
  before a native-speaker reviewer looks. Use this when someone says "review this
  translation", "check this auto-translated page", "is this translation ready to
  merge / to drop the auto banner", or wants a translated index.es/pt/fr.md
  checked for structural parity, which frontmatter was translated, and inclusive
  language. Loads the rules from rladies-translate-page, delegates the inclusive-
  language pass to run-brand-check, and emits a structured Blockers / Warnings /
  Nits report. It does NOT approve or merge — it hands a human a punch list.
---

# Run: RLadies+ Translation Review

An **action** skill that runs the [`rladies-translate-page`](../rladies-translate-page/SKILL.md)
rules against a translated page and its English source. It is a **pre-human gate** — a
native-speaker reviewer still judges the prose; this catches the mechanical and
inclusive-language issues first. It never approves or merges.

Note the boundary: this **cannot judge fluency or cultural fit** in a language it doesn't
reliably read. It checks structure, the technical/frontmatter rules, and the
inclusive-language principle, and it explicitly defers the meaning/naturalness call to
the human reviewer — say so in the report rather than implying the prose was validated.

## Locate both files

You need the **translation** and its **English source**:

- Translation: `content/<section>/<slug>/index.<lang>.md` (`lang` ∈ `es`/`pt`/`fr`).
- Source: `index.en.md` in the same bundle.

For a PR: `gh pr view <n> --json files`, `gh pr diff <n>`, and the `i18n-check` comment
(coverage only — it never blocks).

## Structural parity — BLOCKER / WARNING

The translation must mirror the English structure:

- **Same frontmatter keys** present (values translated per the rules below) → missing
  keys or a broken YAML block that won't render → **Blocker**.
- **Same shortcodes, links, and images** in the same places; image filenames unchanged →
  a dropped/renamed image or a mangled shortcode → **Blocker** (breaks the build/layout).
- Roughly parallel section/heading structure → large structural drift → **Warning**.

## Frontmatter: translate the right fields

Per the guide — translate the **reader-facing** fields, leave the **technical** ones:

- **Translate:** `title`, `description`, `summary`, and any `alt` text.
- **Do NOT translate:** `date`, `directory_id`, image filenames/`path`, `categories`/`tags`
  _keys_, slugs, or any other technical field. A translated `directory_id` or `date` →
  **Warning** (breaks the byline link / sorting).

## The `translated: auto` banner — BLOCKER / WARNING

- If `translated: auto` is still set, the page shows the orange "auto-translated" banner
  and is **not yet a real translation**. If the body still matches the English source
  verbatim (untranslated) but `auto` was removed → **Blocker**: the banner was dropped
  before the work was done.
- If the translation is complete and reviewed, `translated: auto` should be **removed**
  (or set `translated: true`). Flag a finished-looking page that still carries `auto` →
  Warning (drop the banner), and a partial page that dropped it → Blocker.

## Code samples — BLOCKER / WARNING

- **Code must still run unchanged.** Function names, arguments, and keywords
  (`function`, `if`, `else`, `library`, …) stay in English → a translated keyword/function
  name that would break execution → **Blocker**.
- **Comments inside code** should be translated (for meaning, not word-for-word) →
  untranslated comments → Warning. Variable names translated only where it aids clarity
  without hurting readability.

## Inclusive & gender-neutral language

Delegate to [`run-brand-check`](../run-brand-check/SKILL.md) for the inclusive-language
principle, then apply the translation-specific rule: **prefer the target language's
gender-neutral forms and follow the conventions existing translated content already
uses** (Spanish in particular has active community work on inclusive forms). Inconsistency
with the established convention → Warning; exclusionary phrasing → Blocker.

## The report

Emit the **standard tiered report** defined in
[`run-brand-check`](../run-brand-check/SKILL.md) — `## Translation review: <slug>
(<lang>) — <verdict>`, then ⛔ Blockers / ⚠️ Warnings / 💜 Nits (location + suggested
fix) and ✅ Passed, closing with the "no approval or merge" line. Add a standing note:
**"Fluency, meaning, and cultural fit still need a native-speaker reviewer — not checked
here."** Verdict follows the usual rule: any Blocker → ⛔ Blocked.

## Related skills

- The rules this runs → `rladies-translate-page`; inclusive language → `run-brand-check`.
- The page is a blog post → also run `run-blog-review` on the source.
- Reviewing the website PR as a whole → `rladies-website`.
