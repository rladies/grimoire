---
name: rladies-brand
description: >-
  Apply the RLadies+ brand identity to anything community- or public-facing —
  naming, the non-negotiable inclusive-language rule, visual identity, and
  accessibility rules. Use this when you pick brand colours or fonts, use or
  customise the logo, set up brand.yml / glamour / cloak / spellbind for a
  Quarto, Shiny, or pkgdown project, check that copy uses "gender minorities
  in R" rather than "females"/"women only", or check that an asset is on-brand
  and accessible. For the RLadies+ voice and tone itself — the do/don't rules
  and the drafting pass that keeps copy from reading AI-generated — see
  rladies-voice. This is the foundation skill the other RLadies+ content
  skills (rladies-social-posts, rladies-blog-post, rladies-translate-page,
  rladies-branded-assets) build on alongside rladies-voice. Source:
  guide.rladies.org branding and social-media-management sections.
---

# RLadies+ Brand

The **foundation** skill — load it whenever you produce or review anything an RLadies+
audience will see; the other content skills compose on it, alongside
[`rladies-voice`](../rladies-voice/SKILL.md) for tone. The brand was refreshed in
2026; treat pre-2026 assets (old purple `#88398a` / grey `#a7a9ac`, non-Poppins type)
as legacy to replace.

## Naming

- **`RLadies+`** is the written form of the name — never hyphenate it.
- Use **`rladies`** (no plus) only where special characters aren't allowed —
  usernames, account handles, slugs.

## Voice

RLadies+ writes like a friend excited about what the community is doing, not a
corporation issuing announcements — direct, warm, and grounded. The full voice
guide (the do/don't rules, "we"/"our", one exclamation mark max, 💜) and the
sentence-level drafting pass that keeps a draft from reading AI-generated both
live in [`rladies-voice`](../rladies-voice/SKILL.md) — load it for any writing
or review task.

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

- The RLadies+ voice — do/don't rules, AI-sounding tells to strip, before/after
  rewrites → `rladies-voice`.
- Writing/scheduling social posts → `rladies-social-posts`.
- Writing/translating blog posts → `rladies-blog-post`, `rladies-translate-page`.
- Making logos, hex stickers, graphics, slide decks → `rladies-branded-assets`.
