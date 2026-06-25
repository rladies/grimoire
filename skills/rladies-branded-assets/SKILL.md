---
name: rladies-branded-assets
description: >-
  Produce RLadies+ visual assets from the official templates — chapter
  logos and hex stickers, social-media graphics, slide decks, and documents. Use this
  when someone wants to make or customise an RLadies+ logo, hex sticker, Canva social
  graphic, event flyer, Google Slides / PowerPoint deck, or branded document, or asks
  how to fill the R+ submark with a photo, recolour it, or where the templates live.
  Builds on rladies-brand for the colours, fonts, logo-integrity and accessibility
  rules. Source: guide.rladies.org branding (canva-logo, affinity-logo, hex-logos,
  canva-social-media, slidedeck-templates, chapter-branding).
---

# Making RLadies+ Branded Assets

Everything here builds on [`rladies-brand`](../rladies-brand/SKILL.md) — the colours
(Blue Violet `#881ef9`, Poppins), the **logo-integrity rules**, and the accessibility
rules (bold-only emphasis, ≥6pt, high contrast, alt text). Apply those throughout.

All official assets live in the
[branding-materials repo](https://github.com/rladies/branding-materials):
`logos/` (horizontal, vertical, favicon, hex, social-media, circular, quarto),
`templates/slidedecks/`, `templates/documents/`, `templates/certificates/`.

## The one rule for every template

Only edit **placeholder text, images, and logos**. Never change a template's fonts,
colours, or layout, and don't add new elements — use the brand kit's colours and fonts,
never custom values. Keep the accessibility rules in force.

## Logo integrity (applies to every customisation)

> Do not move, transform, or rotate the R relative to the RLadies+ text part of the logo.

Don't edit the logo shapes, recreate it in a different font, change its proportions
(rotate/skew/stretch), or place it on a busy/discontinuous background. When you fill the
R/+ submark with images or colours, **keep every part contrasting with its background**.

## Pick the tool for the job

| Want to make…                          | Use                                             | Notes                                                                               |
| -------------------------------------- | ----------------------------------------------- | ----------------------------------------------------------------------------------- |
| Customised R+ logo (image/colour fill) | Canva or Affinity                               | Canva free can't export transparent backgrounds — use **Affinity** for transparency |
| Chapter hex sticker                    | Affinity hex template, or Canva R+ template     |                                                                                     |
| Social post / event graphic            | Canva **Brand Templates**                       | sizing & template list → `rladies-social-posts`                                     |
| Slide deck                             | Google Slides (free, browser) or PowerPoint     | three colour variants per layout (light/purple/dark)                                |
| Document / certificate                 | `templates/documents`, `templates/certificates` |                                                                                     |
| Quarto doc / Shiny app / package site  | `glamour` / `brand.yml` / `cloak`               | → `rladies-brand` tooling                                                           |

Step-by-step walkthroughs for each tool (Canva logo fill, Affinity layers and
transparent export, hex template editing, slide-deck building) are in
[references/tool-walkthroughs.md](references/tool-walkthroughs.md).

## Chapter rebranding

When a chapter adopts the 2026 brand, update social profile pictures and banners,
Meetup graphics, hex logos, slide templates, and any Quarto docs (`glamour`) or package
sites (`cloak`). Archive pre-2026 assets; don't mix the old purple `#88398a` with the
new `#881ef9`.

> Some countries criminalise LGBTQ+ identity — chapters should adopt branding in
> whatever way is safe for their organisers and members.

## Related skills

- Brand colours, fonts, logo rules, accessibility → `rladies-brand`.
- Which template/size for which platform, and posting → `rladies-social-posts`.
