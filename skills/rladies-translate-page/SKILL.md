---
name: rladies-translate-page
description: >-
  Translate and review pages on the RLadies+ website (rladies.org) into Spanish,
  Portuguese, or French. Use this when reviewing an auto-translated page, translating
  an RLadies+ page or blog post, replacing the orange "auto-translated" banner content
  with a human translation, deciding which frontmatter to translate vs leave, handling
  inclusive/gender-neutral language and code comments in a translation, opening a
  translation PR for @rladies/translation, or registering a brand-new language on the
  site. Builds on rladies-brand for inclusive language. Source: guide.rladies.org
  website/mulit-lingual.
---

# Translating RLadies+ Website Pages

The site (`rladies/rladies.github.io`) is built in **English (`en`, source), Spanish
(`es`), Portuguese (`pt`), and French (`fr`)**. English is the only language exposed in
production; the others are built but held back by `disableLanguages` until enough pages
are reviewed. Most work is **reviewing auto-translated pages** into real translations.

## How auto-translation works

A page that exists as `index.en.md` but not yet in a target language is filled in at
build time by `scripts/missing_translations.R`: it copies the English source, sets
`translated: auto` in the frontmatter, and saves it as `index.<lang>.md`. Hugo renders
that copy under the translated URL with an **orange banner** telling readers it's
auto-translated and inviting review. The placeholder is **not actually translated** —
that's the reviewer's job. Removing `translated: auto` (or setting `translated: true`)
makes the banner disappear and marks the page reviewed.

## Reviewing a page (the common task)

1. **Find pages awaiting review.** Clone and run a local preview:

   ```bash
   git clone https://github.com/rladies/rladies.github.io.git
   cd rladies.github.io
   hugo server
   ```

   Open <http://localhost:1313/>, switch language via the footer picker, and browse.
   Pages with the **orange "auto-translated" banner** are the ones to do. Claim one on
   the [translation tracking project](https://github.com/orgs/rladies/projects/11) so
   two people don't collide.

2. **Edit `content/<section>/<slug>/index.<lang>.md`** (e.g. the Spanish FAQ is
   `content/about-us/faq/index.es.md`). Replace the body with your translation, and
   translate the reader-facing frontmatter — **`title`, `description`, `summary`**.
   **Do not** translate `date`, `directory_id`, image filenames, or other technical
   fields.

3. **Remove `translated: auto`** when the page is fully translated and you're confident.
   If you only got partway, leave it — the banner is honest about the state.

4. **Commit and PR**, tagging [@rladies/translation](https://github.com/orgs/rladies/teams/translation):

   ```bash
   git checkout -b translate-faq-spanish
   git add content/about-us/faq/index.es.md
   git commit -m "Translate FAQ to Spanish"
   git push --set-upstream origin translate-faq-spanish
   ```

   The `i18n-check` action reports coverage (it doesn't block), the build check confirms
   Hugo renders, and a native-speaker reviewer goes through the prose. **Batch related
   pages on one branch / one PR** — one commit per file keeps the diff readable, but the
   reviewer's overhead is per-PR, not per-file. Don't split a batch into many PRs unless
   the topics are unrelated.

## What makes a good translation

A good review is more than swapping words:

- **Meaning, not literal** — the English is sometimes idiomatic; translate the intent.
- **Clarity** — read naturally and correctly in the target language; two short
  sentences beat one awkward long one.
- **Inclusivity & gender-neutral language** — RLadies+ values inclusive language.
  Prefer the target language's gender-neutral forms where they fit, and **follow the
  conventions the existing translated content already uses** (Spanish in particular has
  active community work on inclusive forms).
- **Cultural fit** — a holiday, meme, idiom, or sports analogy that lands in English may
  not elsewhere; substitute, footnote, or rewrite. The reader should feel at home.
- **Code samples** — keep function names, arguments, and keywords (`function`, `if`,
  `else`, `library`, …) in English; **translate comments inside code** (for meaning,
  not word-for-word); translate variable names only where it aids understanding without
  hurting readability. **The code must still run unchanged afterwards** — you're only
  ever translating the human-readable comments around it.

```r
# English source
# Filter the dataset to only include rows where age > 18
adults <- df |> filter(age > 18)

# Good Spanish translation — comment translated, code unchanged (still runs)
# Filtrar el conjunto de datos para incluir solo filas donde edad > 18
adults <- df |> filter(age > 18)
```

## Registering a new language

Rare, and a bigger job — the five-step setup (Hugo `languages.yaml`, copying
`i18n/en.yaml`, the "Read in" badge, localized month names, and the `disableLanguages`
production gate) plus the i18n-check details are in
[references/new-language.md](references/new-language.md).

## Related skills

- Inclusive language and brand voice → `rladies-brand`.
- The page you're translating is a blog post → `rladies-blog-post`.
- Generic Hugo i18n mechanics → `hugo-site`.
