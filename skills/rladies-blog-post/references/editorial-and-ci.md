# Blog post: frontmatter, shortcodes, editorial & CI reference

Deep reference for `rladies-blog-post`. Sources: `website/blog`,
`website/admin_guide/blog`, `website/admin_guide/shortcodes`,
`website/admin_guide/gha`, `website/fork-clone-pr`.

## Frontmatter field catalog

| Field           | Rules                                                                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `title`         | Sentence case, no trailing period.                                                                                                                      |
| `description`   | One or two sentences. Shows under the title in listings and in the OpenGraph card on Slack/LinkedIn. Falls back to an auto summary if omitted.          |
| `author`        | List of `{name, directory_id?, contributions?}`. With `directory_id` the byline links to the profile and the post appears under "Posts by this author". |
| `editorial`     | Same shape as `author`; credits the editor who reviewed the post.                                                                                       |
| `contributions` | Post-level map of single-letter keys → short descriptions (see below).                                                                                  |
| `date`          | `YYYY-MM-DD`. Hard-fail check: must be that exact format and a valid date.                                                                              |
| `categories`    | Broad keywords (click a category on any post to see conventions).                                                                                       |
| `tags`          | Narrower keywords.                                                                                                                                      |
| `image.path`    | Feature image filename, in the same folder as `index.en.md`.                                                                                            |
| `image.alt`     | **Required.** Lighthouse and blog-lint fail the PR without it.                                                                                          |
| `summary`       | Only set if the auto summary (first ~30 words) doesn't suit the listing.                                                                                |

### Contributions (worked example)

Declare a post-level `contributions:` map **and** per-person `contributions: [...]`
lists — both are required or the superscripts silently don't render. Keys are single
lowercase letters mapped to Unicode superscripts; keep descriptions chip-short. The
same mechanism works for a `translator:` block.

```yaml
---
title: "How RLadies+ Santa Barbara built a city-wide R survey"
date: "2026-04-12"
author:
  - name: Beatriz Milz
    directory_id: "beatriz-milz"
    contributions: [a, b]
  - name: Haydee Svab
    directory_id: "haydee-svab"
    contributions: [a, c]
  - name: Tatyane Paz Dominguez
    contributions: [c]
editorial:
  - name: Athanasia Mo Mowinckel
    directory_id: "athanasia-mo-mowinckel"
    contributions: [d]
contributions:
  a: "Wrote the original post"
  b: "Organised community events"
  c: "Conducted the diversity survey"
  d: "Edited for publication"
---
```

## Shortcode & render-hook catalog

**Image → figure** (render hook):

```markdown
![A photograph of attendees at the 2017 useR! conference](user2017.jpg "RLadies+ at useR! 2017")
```

→ `<figure><img ... loading="lazy"><figcaption>…</figcaption></figure>`. First arg =
alt; quoted title = visible caption. Inline images (inside a paragraph) stay plain
`<img>`. Always provide alt text.

**External links** — any link starting with `http` gets
`target="_blank" rel="noopener noreferrer"`; internal links (`/`, `#`, relative) are
left alone. Don't write the target attribute by hand.

**Mermaid** — fenced ` ```mermaid ` blocks render as diagrams; the runtime loads only
on pages that contain one.

**`button`** — positional `{{< button "url" "text" >}}` or named
`{{< button url="…" text="…" >}}`. Renders `<a class="btn btn-primary">` with
`target="_blank"`. Use for a single big call-to-action, not in-prose links.

**`callout`**:

```markdown
{{< callout type="warning" title="Optional" icon="fa-solid fa-rocket" >}}
Body in normal markdown.
{{< /callout >}}
```

| Type      | Default title | Use for                            |
| --------- | ------------- | ---------------------------------- |
| `tip`     | Tip           | Helpful patterns, shortcuts        |
| `info`    | Info          | Neutral context, deeper links      |
| `note`    | Note          | Asides interrupting the main flow  |
| `warning` | Warning       | Things that break if ignored       |
| `danger`  | Danger        | Things that break security or data |

**`rlogo`** — `{{< rlogo width="120px" alt="RLadies+ logo" >}}`; fill with an image via
`image="/images/your-photo.jpg"` (SVG paths become a clip-path over the image).

## Authoring engines (setup)

- **blogdown** — `install.packages("blogdown")`; use the _New Post_ RStudio addin to
  scaffold and `blogdown::serve_site()` to preview. Knitting writes the `.md` next to
  the `.Rmd`; commit both. Theme is `hugo-rladiesplus` (not a blogdown default), so
  previews need Hugo Extended installed. No `renv` needed for posts.
- **hugodown** — `install.packages("hugodown")`;
  `hugodown::render(input = "content/blog/.../index.en.Rmd")`, preview with
  `hugodown::hugo_start()`. Commit `.Rmd` + rendered `.md`.
- **Quarto** — frontmatter just needs `format: hugo-md`; the repo's root `_quarto.yml`
  wires in the `figure-to-markdown.lua` filter automatically. `quarto render path/index.en.qmd`,
  commit the `.md` next to the source.

## Editorial workflow (Airtable)

The blog team runs an Airtable base with three interface areas: **Content Planner**
(post calendar + timelines), **Posts** (overview, request inbox to accept/reject
proposals, latest updates, needs-an-update), and **Tasks** (unfinished, Kanban status,
blocked). Tables: **Proposals**, **Post Status**, **Post Tasks**, **Admins** (synced
from the Global Team Overview base).

Automations (ON): a `#team-blog` Slack ping + author confirmation email on a new
proposal; copy an accepted proposal into Post Status; a publication-approaching ping
when a Due date is within 3 days.

## CI checks on a blog PR

| Workflow                  | Behavior                                                                                                                                                                                                                                                                                 |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `check-build.yaml`        | Runs the production build on every PR.                                                                                                                                                                                                                                                   |
| `blog-lint.yaml`          | Required: `title`, `author`, `date`. Recommended: `description`, `categories`, `image`. **Hard fails**: missing required fields, `date` not `YYYY-MM-DD`, body images without alt text. Soft (suggestions): unstructured authors, missing recommended fields. Comments which file/field. |
| `lighthouse.yaml`         | Lighthouse on key + changed pages vs. live; also Lychee link-check and bundle size. **Fails the PR if any audited image lacks alt text.**                                                                                                                                                |
| `i18n-check.yaml`         | Reports missing i18n keys / translation files as an "i18n Coverage" comment. Does not fail the build.                                                                                                                                                                                    |
| `checklist-blogpost.yaml` | Posts an editorial checklist comment on PRs touching `content/{blog,news}/**/index*`. Informational.                                                                                                                                                                                     |
| `merge-pending.yaml`      | Weekdays 10:58 UTC (and manual dispatch). Squash-merges open PRs labelled `pending` whose frontmatter `date` is today (`gh pr merge --squash --delete-branch --auto`); comments the reason on failure.                                                                                   |

## Fork / clone / PR essentials

Need only **Hugo Extended ≥ 0.144** (`hugo version` should say `extended`). Website-team
members push branches directly to `rladies/rladies.github.io`; others fork and PR.

```bash
git checkout -b add-iwd-recap
hugo server                       # preview at http://localhost:1313/
git add content/blog/2026/06-iwd-recap/index.en.md
git commit -m "blog: IWD 2026 Oslo recap"
git push origin add-iwd-recap
```

Or from R: `usethis::create_from_github("rladies/rladies.github.io")`, then
`usethis::pr_push()`. Common gotcha: the English file is `index.en.md` (a section index
is `_index.en.md`), never `index.md`.
