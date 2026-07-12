---
name: rladies-blog-post
description: >-
  Write, structure, and ship a blog post on the RLadies+ website (rladies.org,
  the rladies/rladies.github.io Hugo site). Use this when someone wants to draft,
  propose, format, or submit an RLadies+ blog post or news item — scaffolding the
  page bundle, filling the YAML frontmatter (author/editor directory_id,
  contributions, date, image alt), authoring in Markdown / R Markdown / Quarto,
  using the site's shortcodes and render hooks (callout, button, rlogo, figures,
  mermaid), passing the blog-lint / Lighthouse / i18n CI checks, and getting it
  scheduled via the pending label and merge-pending workflow. Builds on
  rladies-voice for voice and the drafting pass, and rladies-brand for
  naming/inclusive-language/visual identity. For translating an existing
  post use rladies-translate-page. Source: guide.rladies.org website/blog
  and admin_guide.
---

# Writing an RLadies+ Blog Post

The blog lives in the Hugo site `rladies/rladies.github.io`. Write in the
[RLadies+ voice](../rladies-voice/SKILL.md) (warm, spotlight people, 💜) and run
it through that skill's tell list so the draft doesn't read AI-generated; the
inclusive-language rule ("gender minorities in R") is in `rladies-brand`. The
mechanics below are RLadies+-specific; for generic Hugo and Markdown patterns
lean on the `hugo-site` and `markdown` skills.

## Propose first, then draft

Strongly prefer pitching an idea before writing a full post — open the
[blog-post proposal form](https://rladies.org/form/blog-post). An editor plans the
calendar (so posts don't compete) and shapes scope before you spend hours, and can pair
you up or convert a Google Doc if Git isn't your thing. Proposals and tasks live in an
Airtable base wired to `#team-blog` (see
[references/editorial-and-ci.md](references/editorial-and-ci.md)).

## Scaffold the page bundle

Posts are page bundles under the year, with a `MM-DD-slug` folder for chronological
sorting:

```
content/blog/<year>/<MM-DD-slug>/
└── index.en.md          # add index.es.md / index.pt.md / index.fr.md for translations
```

Scaffold with the archetype:

```bash
hugo new --kind blog blog/2026/06-iwd-recap/index.en.md
```

The feature image and any other assets live **in the same folder** next to `index.en.md`.

## Frontmatter

Minimum required (blog-lint hard-fails without `title`, `author`, `date`, and on a
`date` not in `YYYY-MM-DD`, and on body images without alt text):

```yaml
---
title: "Spelling and casing of the post title"
description: |
  One-line subtitle, used in OG meta and listings. Markdown supported.
author:
  - name: Your Name
    directory_id: "your-directory-slug" # optional but encouraged
editorial:
  - name: Editor Name
    directory_id: "editor-directory-slug"
date: "2026-06-12"
categories: [community]
tags: [iwd, recap, oslo]
image:
  path: "feature-image.png"
  alt: "Description of the feature image, for screen readers"
summary: |
  Optional override for the listing summary.
---
```

- **`title`** — sentence case, no trailing period.
- **`directory_id`** — when an author/editor/translator has a
  [directory profile](https://rladies.org/directory/), add their slug; the byline
  becomes a link and the post shows under "Posts by this author". No profile? Omit it
  (renders as plain text) or add it later via the
  [directory form](https://rladies.org/form/directory-update).
- **`contributions`** — to credit who did what, declare a post-level map and per-person
  lists (both are required or the superscripts silently disappear). See the full
  worked example and field catalog in
  [references/editorial-and-ci.md](references/editorial-and-ci.md).

## Authoring engine

- **Plain Markdown** — the minimum; needs only Hugo Extended (≥ 0.144).
- **R Markdown** (blogdown or hugodown) or **Quarto** (`format: hugo-md`) — render to
  `.md` locally and **commit both the source and the rendered `.md`**; Hugo only sees
  the `.md`, the source is kept for reproducibility. `ignoreFiles` excludes
  `*.Rmd`/`*.qmd` from the build. The site does **not** use `renv` for blog posts.
- **Figures from code** — set both `fig-alt` (what the figure _shows_, for screen
  readers) and `fig-cap` (why it _matters_, the visible caption). They do different
  jobs; if you only set `fig-cap` it's reused as alt text, but write both.

## Shortcodes & render hooks

These are automatic — don't hand-write the HTML:

- **Images become figures** — `![alt text](image.png "Caption")` renders as a
  `<figure>` with `<figcaption>` and `loading="lazy"`. Title = visible caption; omit
  the title for alt-only. **Always provide alt text.**
- **External links** — any `http(s)` link auto-gets `target="_blank" rel="noopener noreferrer"`.
- **Mermaid** — fenced ` ```mermaid ` blocks render as diagrams (loaded only on pages
  that use them).

Shortcodes — `callout` (types `tip`/`info`/`note`/`warning`/`danger`, override
`title=`/`icon=`), `button` for one big call-to-action (not in-prose links), and
`rlogo` (image-fillable via `image=`):

```markdown
{{< callout type="warning" >}}
The directory data is private. **Do not** copy entries into a public PR.
{{< /callout >}}
```

Full syntax catalog in [references/editorial-and-ci.md](references/editorial-and-ci.md).

## Submit and schedule

1. Work on a feature branch; website-team members push directly to
   `rladies/rladies.github.io`, others fork and PR. Both get a Netlify preview comment.
2. Commit the post (and rendered `.md` + source if applicable) and open the PR.
3. CI runs: production build, **blog-lint** (required fields / date format / body-image
   alt text — hard fails), **Lighthouse** (fails the PR if an audited image lacks alt
   text), **i18n coverage** (informational), and an editorial checklist comment.
4. A website-team reviewer is auto-assigned; apply suggestions and push again.
5. To schedule: set the frontmatter `date` to the publication date and add the
   **`pending`** label. The `merge-pending.yaml` workflow runs weekdays at 10:58 UTC
   and squash-merges any `pending` PR whose `date` is today. **Without the `pending`
   label nothing auto-merges** — each post is opted in explicitly.

The CI checks, Airtable editorial workflow, automations, and the full
frontmatter / shortcode catalog are in
[references/editorial-and-ci.md](references/editorial-and-ci.md).

## Related skills

- Voice and the drafting pass → `rladies-voice`. Inclusive language, brand → `rladies-brand`.
- Translating a post into ES/PT/FR → `rladies-translate-page`.
- Announcing the post on social → `rladies-social-posts`.
- Generic Hugo / Markdown mechanics → `hugo-site`, `markdown`.
