---
name: run-blog-review
description: >-
  Run an automated review of an RLadies+ blog post — a local draft, a branch, or
  a GitHub PR on rladies/rladies.github.io — as a pre-human-review gate before an
  editor or website reviewer looks. Use this when someone says "review this blog
  post", "run a blog review / blog-lint on this draft or PR", "is this post ready
  to submit", or wants a post checked for frontmatter, image alt text, shortcodes,
  voice, and CI expectations. Loads the rules from rladies-blog-post, delegates
  the voice/inclusive-language pass to run-brand-check, and emits a structured
  Blockers / Warnings / Nits report. It does NOT approve, merge, or add the
  pending label — it hands a human a punch list.
---

# Run: RLadies+ Blog Post Review

An **action** skill that runs the [`rladies-blog-post`](../rladies-blog-post/SKILL.md)
rules against a real post and produces a review an editor can act on. It is a
**pre-human gate** — it mirrors the blog-lint / Lighthouse hard-fails so problems are
caught _before_ a person or CI does, but it never approves, merges, or applies the
`pending` label.

## Locate the artifact

Accept any of:

- **A path** to a page bundle or `index.<lang>.md` → read it directly.
- **A branch** → `git diff main...<branch> --name-only` to find changed post files.
- **A PR** → `gh pr view <n> --json files,title,body`, `gh pr diff <n>`, and (crucially)
  the real CI results: `gh pr checks <n>` plus the blog-lint / Lighthouse / i18n
  comments via `gh pr view <n> --comments`. Fold actual CI output into the report
  rather than only predicting it.

If Rmd/Quarto source is present, review the committed rendered `.md` (that's what Hugo
sees) and confirm the source is committed alongside it.

## Frontmatter checks (mirror the blog-lint hard-fails)

Parse the YAML frontmatter. These are the **Blockers** blog-lint enforces:

- **`title`** present. → also Warning if not sentence case or has a trailing period.
- **`author`** present.
- **`date`** present **and** matches `YYYY-MM-DD` exactly:

  ```bash
  grep -nE '^date:' index.en.md   # must be "YYYY-MM-DD", quoted or not
  ```

- **`image.alt`** present and non-empty whenever `image.path` is set → Blocker if missing
  (Lighthouse hard-fails an audited image with no alt).

Softer frontmatter checks (**Warnings**):

- Each `author` / `editorial` entry has a `directory_id` → Warning if missing (byline
  won't link / won't show under the author's posts). Omitting is allowed, so Warning
  not Blocker.
- If `contributions` is used, both the **post-level map and per-person lists** must be
  present — if only one side exists, the superscripts silently vanish → Warning.
- `categories` / `tags` present and lowercased → Nit.

## Body checks

- **Every body image has non-empty alt text** — the Lighthouse hard-fail. Scan for
  empty-alt Markdown images:

  ```bash
  grep -nE '!\[[[:space:]]*\]\(' index.en.md   # ![](...) with empty alt → Blocker
  ```

  Use `alt=""` only for genuinely decorative images.

- **Figures generated from code** set both `fig-alt` (what it shows) and `fig-cap` (why
  it matters) → Warning if only one.
- **Shortcodes well-formed** — `callout` uses a valid type
  (`tip`/`info`/`note`/`warning`/`danger`) and is closed (`{{< /callout >}}`); `button`
  used for one call-to-action, not in-prose links; `rlogo` well-formed → Warning on any
  malformed/unclosed shortcode (a broken shortcode fails the production build).
- Don't hand-write figure/link HTML — images and external links get render hooks
  automatically; flag hand-rolled `<figure>`/`<a target>` as a Nit.

## Voice & inclusive language

Delegate the prose to [`run-brand-check`](../run-brand-check/SKILL.md): RLadies+ voice
(warm, spotlight people, one exclamation max, 💜), **"gender minorities in R"** (never
"females"/"women only"), naming (`RLadies+` not hyphenated), and accessibility. Merge
its Blockers/Warnings/Nits into this report.

## The report

Emit the **standard tiered report** defined in
[`run-brand-check`](../run-brand-check/SKILL.md) — `## Blog review: <post> — <verdict>`,
then ⛔ Blockers / ⚠️ Warnings / 💜 Nits (each with location + suggested fix) and ✅
Passed, closing with the "no approval or merge" line. Verdict rule: any Blocker →
⛔ Blocked; Warnings only → ⚠️ Needs changes first; Nits/none → ✅ Ready for human review.

When reviewing a PR, add a one-line **CI reality** note per check (e.g. "blog-lint: red —
missing `date`; matches our Blocker above") so the human sees prediction vs actual.

## Related skills

- The rules this runs → `rladies-blog-post`; voice → `run-brand-check` / `rladies-brand`.
- Reviewing the whole website PR (build, JSON, chapters) → `rladies-website`.
- Reviewing a translated post → `run-translation-review`.
