# Website architecture, GHA suite & directory pipeline

Deep reference for `rladies-website`. Sources: `website/admin_guide` (hugo, gha,
directory-pipeline, seo, sections, dark-mode, assets).

## Hugo architecture

- **Hugo Extended ≥ 0.144**; theme `themes/hugo-rladiesplus/` (fork of Hugo Initio,
  rewritten on Tailwind v4 + Alpine). CSS/JS pre-built and committed — no Node/npm/R for
  `hugo server`.
- **Config split**: `config/_default/` (hugo.yaml, languages.yaml, markup.yaml, menu.yaml,
  params.yaml) merged with `development/` (relative baseURL, drafts on) or `production/`
  (rladies.org baseURL, `disableLanguages: [es, pt, fr]`).
- **Content** = page bundles at `content/<section>/<slug>/index.<lang>.md`. `.Rmd`/`.qmd`
  are excluded via `ignoreFiles`; only rendered `.md` is built.
- **Render hooks**: images → `<figure>`+caption (with title) and `loading="lazy"`;
  `http` links → `target="_blank" rel="noopener noreferrer"`; ` ```mermaid ` → diagram.
- **Shortcodes** `button` / `callout` / `rlogo` — catalog in `rladies-blog-post`.
- **Dark mode**: `assets/js/darkmode.js` (inline in `<head>`, respects
  `prefers-color-scheme`), Tailwind `dark:` variant on `.dark`; no separate stylesheet.
- **Data**: `data/chapters/` (per-chapter JSON), `data/directory/` (from the directory
  repo at build; only `sample-*.json` committed), `data/global_team/` (Airtable sync),
  `data/continents.yaml`, `data/months/<lang>.yaml`, `data/read_in_lang.yaml`,
  `data/sponsors.json`. Remote fetches at build: meetup_archive events,
  awesome-rladies-creations packages/content.

## GHA suite

- **`build-production.yaml`** — deploys to rladies.org on push to `main` + cron
  `45 */12 * * *`: sets up R (`RENV_PROFILE=production`), runs `missing_translations.R`,
  clones `rladies/directory` via deploy key (json→`data/directory`, img→
  `assets/directory`), Hugo Extended at `.hugoversion`, `hugo -e production`, deploys to
  `gh-pages` (GitHub Pages serves it; no Netlify in production).
- **`build-preview.yaml`** — every PR (incl. forks) gets a Netlify preview; the directory
  repo can dispatch with `directory: <run_id>` to preview one unmerged entry.
- **`check-build.yaml`** — production-style build on every PR (the gate).
- **`check-jsons.yaml`** — `validate_jsons.R` against `scripts/json_shema/`; in-place PR
  comment.
- **`blog-lint.yaml`**, **`merge-pending.yaml`**, **`checklist-blogpost.yaml`** — blog
  side; details in `rladies-blog-post`.
- **`i18n-check.yaml`** — coverage comment; never fails (placeholders auto-generated).
- **`lighthouse.yaml`** — Lighthouse vs production + Lychee link check + bundle table;
  **fails on missing alt text**.
- **`global-team.yml`** — Sundays 16:16 UTC; pulls global-team data from Airtable
  (`get_global_team.R`), commits to `data/global_team/` + headshots, pushes to protected
  `main` via a service account.

## Directory pipeline

- Canonical data in private **`rladies/directory`**: one `data/json/<id>.json` + image per
  member. Separate repo for **privacy** (some submitted fields shouldn't appear in public
  PR previews). Website repo ships only `data/directory/sample-*.json`.
- Entry JSON carries `directory_id` (the load-bearing slug → `/directory/<id>/` URL and the
  cross-site foreign key), `name`, `image`, `location`, `languages`, `interests`,
  `categories`, `contact_method`, `social_media`, `work`, `activities`, `last_updated`.
- Images live in `assets/directory/<id>.<ext>`; Hugo resizes to **400×400 webp** (cards),
  **1200×630** (profile OG), and hex-wall.
- The **profile page** (`directory/single.html`) scans all site pages for `author` /
  `editorial` / `translator` entries whose `directory_id` matches → "Posts" / "Edited" /
  "Translated"; and filters `awesome-rladies-creations` by `authors[*].directory_id` for a
  package hex wall. The list page filters via Choices.js + Shuffle.js.
- **Common failures**: JSON schema error; image not where templates expect; a **stale
  `directory_id`** (member renamed their slug but a post still references the old one).
