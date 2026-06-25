# RLadies+ Skills

A collection of [Agent Skills](https://www.anthropic.com/news/skills) that help the
[RLadies+](https://rladies.org/) community and global team follow the
[RLadies+ guide](https://guide.rladies.org/) — from writing in the RLadies+ voice,
through blogging, translation, and social media, to coordinating the work the global
team does behind the scenes.

Each skill packages the relevant parts of the guide into focused, on-demand guidance
that an LLM agent (e.g. Claude) loads only when it's actually needed. The set is
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

`rladies-brand` is the foundation — the voice, inclusive language, visual identity,
and accessibility rules every content skill builds on. The rest compose on top of it.

| Skill                              | What it helps with                                                                                                                                                                                                                                                                | Status       |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| **`rladies-brand`**                | The RLadies+ voice and tone, inclusive language ("gender minorities in R"), visual identity (Blue Violet `#881ef9`, Poppins, logo integrity), accessibility rules, and the brand tooling (`brand.yml`, `glamour`, `cloak`, `spellbind`). The base the others build on. | ✅ available |
| **`rladies-blog-post`**            | Draft, structure, and ship a post on the Hugo website: page bundles, frontmatter (`directory_id`, contributions, image alt), Markdown/Rmd/Quarto, shortcodes and render hooks, the blog-lint / Lighthouse / i18n CI checks, and scheduling via the `pending` label.               | ✅ available |
| **`rladies-social-posts`**         | Draft, schedule, and curate social across Bluesky, Mastodon, LinkedIn, Instagram, and YouTube: cadence and timing, platform image sizes, Buffer, what the global `@rladies` account should amplify, and IWD campaigns.                                                            | ✅ available |
| **`rladies-translate-page`**       | Review auto-translated pages and translate the site into Spanish, Portuguese, or French: the `translated: auto` workflow, which frontmatter to translate, inclusive/cultural guidance, code-comment rules, and the `@rladies/translation` PR flow.                                | ✅ available |
| **`rladies-abstract-review`**      | Coordinate the abstract-review service: match conference-abstract and funding-application requests to volunteer reviewers, draft the invitation, and track everything in Airtable.                                                                                                | ✅ available |
| **`rladies-branded-assets`**       | Make logos, chapter hex stickers, social graphics, and slide decks from the official Canva / Affinity / Slides / PowerPoint templates.                                                                                                                                            | ✅ available |
| **`rladies-chapter-event`**        | Plan and run a chapter event end-to-end: diverse speakers, scheduling, promotion, the shared-Zoom host-key workflow, code-of-conduct, YouTube, thank-yous.                                                                                                                        | ✅ available |
| **`rladies-rocur`**                | Run WeAreRLadies rotating curation: recruit and onboard curators, schedule, intro graphics, the curator emails, and the Bluesky app-password handover.                                                                                                                            | ✅ available |
| **`rladies-website`**              | Maintain the Hugo site: review PRs (GHA outputs + Netlify previews), add/update chapters, redirects, SEO/social cards, and the directory pipeline.                                                                                                                                | ✅ available |
| **`rladies-partnership-eval`**     | Assess partnership / ally / conference requests against the mission and rules (anti diversity-washing, code-of-conduct and speaker-diversity checks).                                                                                                                             | ✅ available |
| **`rladies-chapter-setup`**        | Start, onboard, and keep a chapter compliant over its lifetime — the chapters@ onboarding flow, Meetup/email/security setup, the rules, co-organizers, monitoring, retirement, reactivation.                                                                                      | ✅ available |
| **`rladies-funding`**              | Sponsorship pitches, R Consortium (RUGS) grants, expense reimbursement (forms, PDF naming, monthly deadline), and donation acknowledgement.                                                                                                                                       | ✅ available |
| **`rladies-community-moderation`** | Moderate the community Slack and uphold the Code of Conduct: who it's for, channel/thread hygiene, inclusive language, allowed/disallowed posts, and harassment reporting/escalation.                                                                                             | ✅ available |

All thirteen skills from the project's evaluation are now available.

## Layout

The repo is packaged as a single Claude Code plugin (`rladies-skills`) that bundles
the skills, and doubles as a one-plugin marketplace:

```
rladies-skills/
├── .claude-plugin/
│   ├── marketplace.json   # the marketplace catalog
│   └── plugin.json        # the plugin manifest
└── skills/
    └── <skill-name>/
        ├── SKILL.md        # lightweight guidance, loaded when the skill triggers
        └── references/     # deeper detail (templates, schemas, walkthroughs), on demand
```

The thirteen skills: `rladies-brand` (foundation) · `rladies-blog-post` ·
`rladies-social-posts` · `rladies-translate-page` · `rladies-abstract-review` ·
`rladies-branded-assets` · `rladies-chapter-event` · `rladies-rocur` ·
`rladies-website` · `rladies-partnership-eval` · `rladies-chapter-setup` ·
`rladies-funding` · `rladies-community-moderation`.

Each skill follows the Agent Skills format: `SKILL.md` carries the lightweight
guidance loaded once the skill triggers, while `references/` holds the deeper detail
the agent reads only when a task calls for it.

## Installing

In [Claude Code](https://docs.claude.com/en/docs/claude-code), add this repo as a
marketplace and install the plugin:

```text
/plugin marketplace add rladies/rladies-skills
/plugin install rladies-skills@rladies-skills
```

`/plugin marketplace update` pulls newer versions later, and `/plugin` opens the
manager to enable, disable, or uninstall.

## Contributing

These skills distil [guide.rladies.org](https://guide.rladies.org/). When the guide
changes, update the matching skill. New skills should follow the same pattern: a tight
`SKILL.md` with a trigger-rich `description`, deeper material in `references/`, and the
RLadies+ voice and inclusive-language rules from `rladies-brand` throughout.
