---
name: rladies-website
description: >-
  Maintain the RLadies+ website (rladies.org, the rladies/rladies.github.io Hugo site) —
  the site-maintenance side, as opposed to writing posts. Use this when reviewing a
  website pull request, reading the GitHub Actions checks or a Netlify preview, adding or
  updating a chapter (the chapters JSON), retiring an organizer, creating a redirect /
  short URL, fixing a Slack/LinkedIn/Bluesky social preview card or SEO, or understanding
  the directory data pipeline and the Hugo architecture/config. For writing or scheduling
  a blog post (frontmatter, shortcodes, fork/clone/PR, blog-lint, merge-pending) use
  rladies-blog-post instead. Source: guide.rladies.org website/admin_guide, chapter,
  organizers.
---

# Maintaining the RLadies+ Website

The site is a Hugo Extended (≥ 0.144) site using the vendored `hugo-rladiesplus` theme
(Tailwind v4 + Alpine, CSS/JS pre-built — no Node/R needed for `hugo server`). Config is
split across `config/{_default,development,production}`. **Authoring posts is a separate
skill** → `rladies-blog-post`; this skill is reviewing, chapters, redirects, SEO, the
directory pipeline, and architecture.

## Reviewing a pull request

PRs auto-assign to a website-team member via **CODEOWNERS** — if it's you, you own
getting it reviewed (not necessarily doing it; reassign in `#team-website` if needed).

**Read the CI comments in order:**

1. **`check-build`** — the gate. If red, nothing else matters; read the last few hundred
   log lines (usually bad frontmatter YAML, a broken shortcode, or an unresolvable image).
2. **`check-jsons`** — validates chapters/directory/sponsors JSON against the schemas;
   names the file and field on failure.
3. **`blog-lint`** (blog/news only) — frontmatter check → details in `rladies-blog-post`.
4. **`lighthouse`** — per-page vs production; **hard-fails if an audited image has no alt
   text**; also runs the Lychee link check.
5. **`i18n-check`** — informational coverage comment; never fails the build.

**Then open the Netlify preview** (every PR gets one) — CI can't see what it can: does it
look right in **light _and_ dark mode**, do contribution superscripts line up, does the
directory photo show, is the heading hierarchy sane, did a shortcode silently fail? For
content PRs read the prose and confirm `directory_id` bylines resolve; for translations
compare against English structure; for layout/theme changes **pull the branch locally**
and check dark mode on home + blog + directory.

**Verdict & merge**: `Approve` (good as-is), `Request changes` (a hard block — use
sparingly, prefer a kind `Comment` for first-timers), `Comment` (everything else; inline
`suggestion` blocks are one-click). Merge with **Rebase merge** (the default; matches
`merge-pending`); `Squash` for many WIP commits; avoid merge commits. **Watch the
production build** after merging.

The full GHA suite (build-production, build-preview, global-team, merge-pending, etc.) is
in [references/architecture-and-pipeline.md](references/architecture-and-pipeline.md).

## Adding / updating a chapter

Create `data/chapters/<country-state-city>.json` (lowercased, dashes; drop the state
segment if none) — the filename becomes the URL. Set `status` (`prospective`/`active`/
`inactive` — only **active** appears on the world map), `urlname` (the Meetup slug, used
to fetch events), `country`/`city` (country must match `data/continents.yaml`),
`social_media`, and `organizers.current`/`former`. An optional image goes in
`assets/chapters/<same-name>.png`. **Retiring an organizer**: move them from `current` to
`former` (never delete) and change their Meetup role to member. The full schema and the
social-media key list are in
[references/chapters-and-redirects.md](references/chapters-and-redirects.md).

## Redirects (short URLs)

A redirect is a frontmatter-only markdown file: `type: redirect`, `redirect: <url>`, and
optional `aliases: [...]` for legacy paths. Form redirects live in `content/form/`
(`content/form/blog-post.md` → `rladies.org/form/blog-post`); one-offs at the content
root. Query strings pass through. **Always share the pretty `rladies.org/...` URL, never
the underlying Airtable/Slido one** — the pretty URL is the contract. Scaffold:
`hugo new --kind redirect form/awesome-thing.md`. Spec in
[references/chapters-and-redirects.md](references/chapters-and-redirects.md).

## SEO & social preview cards

`partials/head/meta.html` generates the cards. **OG image fallback order**: page
`image.path` (resized to **1200×630**) → first page image → site `params.ogImage`. The
description falls back to the site description; `og:type` is `article` only on blog/news.
**JSON-LD authorship threads through `directory_id`** — if a post should show an authored
byline in search, check its author entry carries a `directory_id`. hreflang alternates
cover translations; `robots.txt` and `sitemap.xml` are auto-generated; missing alt text
fails the build (use `alt=""` only for decorative images).

## Directory pipeline (how member data reaches the site)

The canonical data is in the **private `rladies/directory`** repo (one JSON + image per
member); the website repo only ships `data/directory/sample-*.json` for local preview.
The production build clones it via a **deploy key**, copies `data/json/` → `data/directory/`
and `data/img/` → `assets/directory/`, and Hugo resizes photos (cards **400×400 webp**,
OG **1200×630**). **`directory_id` is the foreign key** linking a member to their blog
bylines, edits, translations, global-team entry, and packages (from
`awesome-rladies-creations`). Full schema, profile-page mechanics, and the common failure
modes are in [references/architecture-and-pipeline.md](references/architecture-and-pipeline.md).

## Related skills

- Writing/scheduling a post, the shortcode catalog, fork/clone/PR → `rladies-blog-post`.
- Translation reviews and new languages → `rladies-translate-page`.
- Generic Hugo patterns → `hugo-site`.
