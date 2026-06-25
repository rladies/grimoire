---
name: rladies-brand
description: >-
  Apply the RLadies+ brand to anything community- or public-facing —
  the voice and tone, inclusive language, visual identity, and accessibility
  rules. Use this whenever you write or review copy "in the RLadies+ voice", draft
  a social post / blog / email / slide / announcement for RLadies+, pick brand
  colours or fonts, use or customise the logo, set up brand.yml / glamour / cloak /
  spellbind for a Quarto, Shiny, or pkgdown project, or check that something is
  on-brand and accessible. This is the foundation skill the other RLadies+ content
  skills (rladies-social-posts, rladies-blog-post, rladies-translate-page,
  rladies-branded-assets) build on. Source: guide.rladies.org branding and
  social-media-management sections.
---

# RLadies+ Brand & Voice

The **foundation** skill — load it whenever you produce or review anything an RLadies+
audience will see; the other content skills compose on it. The brand was refreshed in
2026; treat pre-2026 assets (old purple `#88398a` / grey `#a7a9ac`, non-Poppins type)
as legacy to replace.

## Naming

- **`RLadies+`** is the written form of the name — never hyphenate it.
- Use **`rladies`** (no plus) only where special characters aren't allowed —
  usernames, account handles, slugs.

## Voice

> We sound like a friend who's excited about what the community is doing — not a
> corporation issuing announcements. Our voice is direct, warm, and grounded.
> We're a movement but we don't take ourselves too seriously.

**Do**

- Use "we" and "our" — we're part of the community, not above it.
- Lead with what's happening, not who we are.
- Keep it short — punchy lines, not paragraphs.
- Name people and chapters specifically — spotlight others, not the org.
- End with a clear call to action (link, sign-up, "come say hi").
- Use the purple heart 💜 as our signature emoji.

**Don't**

- Sound corporate, formal, or institutional.
- Use jargon or acronyms without context.
- Over-explain — trust the reader.
- Centre the global org over the people and chapters.
- Use exclamation marks excessively — one per post max.
- Say "females" or "women only".

## Inclusive language (non-negotiable)

- We say **"gender minorities in R"**, never "females" or "women only".
- RLadies+' mission is gender diversity in the R community, for **minority genders
  including but not limited to cis/trans women, trans men, non-binary, genderqueer,
  and agender** people. Frame copy so all of these readers feel addressed.
- When translating, prefer the target language's gender-neutral forms and follow
  the conventions existing translations already use (→ `rladies-translate-page`).

## Visual identity

**Colours** — use Blue Violet primarily, combined with the basic colours; accents
sparingly. Use Bastille Black / Lavender White instead of pure `#000000` / `#ffffff`.
Each colour also has 75% / 50% / 25% tints in the `brand.yml`.

| Role   | Name           | Hex       |
| ------ | -------------- | --------- |
| Main   | Blue Violet    | `#881ef9` |
| Accent | Dodger Blue    | `#146af9` |
| Accent | Brilliant Rose | `#ff5b92` |
| Basic  | Bastille Black | `#2f2f30` |
| Basic  | Lavender White | `#ededf4` |

**Typography** — **Poppins** for everything (Medium for main titles, SemiBold for
headings, Regular for body, **Bold** for emphasis); **Inconsolata** for monospace.
Maintain visual hierarchy: titles largest, headings sized by level, body consistent.

**Logo** — vertical (stacked) is the default; horizontal when vertical space is
tight. Pick the colour variant that contrasts with the background (full colour or
Bastille Black on light, Lavender White on dark). The R and + of the submark can be
filled with images or brand colours — keep every part contrasting with its background
(→ `rladies-branded-assets`). **Never** edit the
logo shapes, move the R icon relative to its text, recreate it in a different font,
rotate / skew / stretch it, or place it on a busy or discontinuous background. Leave
clear space around it.

## Accessibility (non-negotiable)

- **Contrast**: text must always have high contrast with its background — the
  smaller the text, the higher the contrast. Verify with a tool like
  <https://colourcontrast.cc>.
- **Formatting**: avoid underlined, italic, and all-caps text. Use **bold** for
  emphasis. Left-align text.
- **Text size**: never smaller than **6 points**.
- **Line spacing**: at least **1.5 pt**.
- **Alt text**: always add alt text describing the image, including any text shown
  in it.

## Machine-readable brand & R tooling

Prefer these over hand-rolling colours/fonts — all live in the
[branding-materials repo](https://github.com/rladies/branding-materials) and stay in
sync with the official definition:

- **`brand.yml`** — palette (incl. tints), typography, and logos for
  [Quarto](https://quarto.org/docs/authoring/brand.html) and
  [Shiny](https://shiny.posit.co/).
- **[glamour](https://github.com/rladies/glamour)** — Quarto extension that brands docs
  and presentations.
- **[spellbind](https://github.com/rladies/spellbind)** — R package of the brand colours.
- **[cloak](https://github.com/rladies/cloak)** — pkgdown theme for package websites.

The generic `brand-yml` skill covers applying `brand.yml`; this skill supplies the
actual RLadies+ values.

## Producing branded assets

Logos, hex stickers, social graphics, and slide decks come from official templates
(Canva, Affinity, Google Slides, PowerPoint) — only edit placeholder text, images, and
logos; never change templates' fonts, colours, or layout. The step-by-step tool
walkthroughs live in `rladies-branded-assets`.

## Related skills

- Writing/scheduling social posts in this voice → `rladies-social-posts`.
- Writing/translating blog posts → `rladies-blog-post`, `rladies-translate-page`.
- Making logos, hex stickers, graphics, slide decks → `rladies-branded-assets`.
