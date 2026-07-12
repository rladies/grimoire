# Grimoire

A **grimoire** — a book of spells — for the [RLadies+](https://rladies.org/) community
and global team: a collection of [Agent Skills](https://www.anthropic.com/news/skills)
that help everyone follow the [RLadies+ guide](https://guide.rladies.org/), from writing
in the RLadies+ voice, through blogging, translation, and social media, to coordinating
the work the global team does behind the scenes. The name is a nod to the rest of the
witch-themed RLadies+ tooling — [`glamour`](https://github.com/rladies/glamour),
[`cloak`](https://github.com/rladies/cloak), and
[`spellbind`](https://github.com/rladies/spellbind).

Each skill (a _spell_) packages the relevant parts of the guide into focused, on-demand
guidance that an LLM agent (e.g. Claude) loads only when it's actually needed. The set is
modelled on the [rOpenSci Skills](https://github.com/drmowinckels/ropensci-skills)
repo.

## What makes something a skill here

RLadies+ is a community non-profit, so the work clusters around **communications,
content, governance, and the website** rather than code. The strongest skills are the
ones where an agent can actually **produce, standardise, or review an artifact** — a
post, a blog draft, a translation, a review assignment. Tasks that are purely
clicking through an external portal (rotating an API key, triaging mail, operating a
phone line, nonprofit filings) stay in the guide as runbooks; they aren't agent
skills.

## The skills

`rladies-voice` and `rladies-brand` are the two foundation skills every content skill
builds on: `rladies-voice` covers the voice and tone (the do/don't rules and the
drafting pass that keeps copy from reading AI-generated), `rladies-brand` covers
naming, the non-negotiable inclusive-language rule, visual identity, and
accessibility. The rest compose on top of both.

| Skill                              | What it helps with                                                                                                                                                                                                                                                          | Status       |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| **`rladies-voice`**                | The RLadies+ voice, in full: the identity-level do/don't rules ("we"/"our", spotlight people, one exclamation mark max, 💜) plus the sentence-level drafting pass — concrete AI-sounding tells to strip and before/after rewrites, for blog, social, event, and Slack copy. | ✅ available |
| **`rladies-brand`**                | Naming (`RLadies+`), the non-negotiable inclusive-language rule ("gender minorities in R"), visual identity (Blue Violet `#881ef9`, Poppins, logo integrity), accessibility rules, and the brand tooling (`brand.yml`, `glamour`, `cloak`, `spellbind`).                    | ✅ available |
| **`rladies-blog-post`**            | Draft, structure, and ship a post on the Hugo website: page bundles, frontmatter (`directory_id`, contributions, image alt), Markdown/Rmd/Quarto, shortcodes and render hooks, the blog-lint / Lighthouse / i18n CI checks, and scheduling via the `pending` label.         | ✅ available |
| **`rladies-social-posts`**         | Draft, schedule, and curate social across Bluesky, Mastodon, LinkedIn, Instagram, and YouTube: cadence and timing, platform image sizes, Buffer, what the global `@rladies` account should amplify, and IWD campaigns.                                                      | ✅ available |
| **`rladies-translate-page`**       | Review auto-translated pages and translate the site into Spanish, Portuguese, or French: the `translated: auto` workflow, which frontmatter to translate, inclusive/cultural guidance, code-comment rules, and the `@rladies/translation` PR flow.                          | ✅ available |
| **`rladies-abstract-review`**      | Coordinate the abstract-review service: match conference-abstract and funding-application requests to volunteer reviewers, draft the invitation, and track everything in Airtable.                                                                                          | ✅ available |
| **`rladies-branded-assets`**       | Make logos, chapter hex stickers, social graphics, and slide decks from the official Canva / Affinity / Slides / PowerPoint templates.                                                                                                                                      | ✅ available |
| **`rladies-chapter-event`**        | Plan and run a chapter event end-to-end: diverse speakers, scheduling, promotion, the shared-Zoom host-key workflow, code-of-conduct, YouTube, thank-yous.                                                                                                                  | ✅ available |
| **`rladies-rocur`**                | Run WeAreRLadies rotating curation: recruit and onboard curators, schedule, intro graphics, the curator emails, and the Bluesky app-password handover.                                                                                                                      | ✅ available |
| **`rladies-website`**              | Maintain the Hugo site: review PRs (GHA outputs + Netlify previews), add/update chapters, redirects, SEO/social cards, and the directory pipeline.                                                                                                                          | ✅ available |
| **`rladies-partnership-eval`**     | Assess partnership / ally / conference requests against the mission and rules (anti diversity-washing, code-of-conduct and speaker-diversity checks).                                                                                                                       | ✅ available |
| **`rladies-chapter-setup`**        | Start, onboard, and keep a chapter compliant over its lifetime — the chapters@ onboarding flow, Meetup/email/security setup, the rules, co-organizers, monitoring, retirement, reactivation.                                                                                | ✅ available |
| **`rladies-funding`**              | Sponsorship pitches, R Consortium (RUGS) grants, expense reimbursement (forms, PDF naming, monthly deadline), and donation acknowledgement.                                                                                                                                 | ✅ available |
| **`rladies-community-moderation`** | Moderate the community Slack and uphold the Code of Conduct: who it's for, channel/thread hygiene, inclusive language, allowed/disallowed posts, and harassment reporting/escalation.                                                                                       | ✅ available |

All thirteen skills from the project's evaluation are now available.
`rladies-voice` was added afterward as the RLadies+ voice skill — the identity-level
do/don't rules that used to live in `rladies-brand`'s Voice section now live there,
alongside the drafting/AI-tell material.

## Running reviews (the `run-*` skills)

The `rladies-*` skills above are **context** skills — an agent loads them when a task is
relevant and they supply the rules. On top of them sits a set of **action** skills that a
team member invokes explicitly to _run a review on an artifact as a pre-human gate_: point
one at a draft, a branch, or a PR and it loads the matching context skill, executes the
checklist (and any real commands — blog-lint expectations, alt-text scans,
inclusive-language greps, live CI output on a PR), and emits a consistent **Blockers /
Warnings / Nits** report with a location and a suggested fix for each finding. They never
approve, merge, schedule, or publish — they hand a human a punch list.

| Skill                        | Runs a review of…                                                                                                                                                         | Builds on                        |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| **`run-brand-check`**        | Any copy or asset against the brand rubric: voice, AI-sounding tells, inclusive language, accessibility, naming, visual identity. The shared core the others delegate to. | `rladies-voice`, `rladies-brand` |
| **`run-blog-review`**        | A blog draft / branch / PR: frontmatter (blog-lint hard-fails), body-image alt text, shortcodes, rendered `.md`, voice — plus live CI results on a PR.                    | `rladies-blog-post`              |
| **`run-social-review`**      | A drafted post / thread: voice, alt text, one-exclamation-max, hashtags, image ratio per platform, and the leadership-review flag before it hits Buffer.                  | `rladies-social-posts`           |
| **`run-translation-review`** | A translated `index.<lang>.md` vs its English source: structural parity, which frontmatter to translate, the `translated: auto` banner state, code comments.              | `rladies-translate-page`         |

They all emit the same tiered report (defined in `run-brand-check`), so reviewers get
familiar output whichever one they run.

## Layout

The repo is packaged as a single Claude Code plugin (`grimoire`) that bundles
the skills, and doubles as a one-plugin marketplace:

```
grimoire/
├── .claude-plugin/
│   ├── marketplace.json   # the marketplace catalog
│   └── plugin.json        # the plugin manifest
└── skills/
    └── <skill-name>/
        ├── SKILL.md        # lightweight guidance, loaded when the skill triggers
        └── references/     # deeper detail (templates, schemas, walkthroughs), on demand
```

The fourteen context skills: `rladies-voice` (voice, foundation) · `rladies-brand`
(identity, foundation) · `rladies-blog-post` · `rladies-social-posts` ·
`rladies-translate-page` · `rladies-abstract-review` · `rladies-branded-assets` ·
`rladies-chapter-event` · `rladies-rocur` · `rladies-website` ·
`rladies-partnership-eval` · `rladies-chapter-setup` · `rladies-funding` ·
`rladies-community-moderation`.

The action (`run-*`) skills: `run-brand-check` (shared core) · `run-blog-review` ·
`run-social-review` · `run-translation-review`.

Each skill follows the Agent Skills format: `SKILL.md` carries the lightweight
guidance loaded once the skill triggers, while `references/` holds the deeper detail
the agent reads only when a task calls for it. The `run-*` skills are pure `SKILL.md`
(no `references/`) — they orchestrate the context skills rather than adding new
material.

## Installing

In [Claude Code](https://docs.claude.com/en/docs/claude-code), add this repo as a
marketplace and install the plugin:

```text
/plugin marketplace add rladies/grimoire
/plugin install grimoire@grimoire
```

`/plugin marketplace update` pulls newer versions later, and `/plugin` opens the
manager to enable, disable, or uninstall.

## Contributing

Most of these skills distil [guide.rladies.org](https://guide.rladies.org/); when the
guide changes, update the matching skill. Part of `rladies-voice` is guide-distilled
(the identity-level do/don't rules) and part is a practical companion authored
alongside it (the AI-tell material) — its `SKILL.md` says so up front. New skills
should follow the same pattern: a tight `SKILL.md` with a trigger-rich `description`,
deeper material in `references/`, and the RLadies+ voice rules from `rladies-voice`
and inclusive-language rules from `rladies-brand` throughout.
