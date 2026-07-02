---
name: run-social-review
description: >-
  Run an automated review of a drafted RLadies+ social post or thread (Bluesky,
  Mastodon, LinkedIn, Instagram, YouTube) as a pre-human-review gate before it is
  scheduled or approved in Buffer. Use this when someone says "review this social
  post", "check this before I schedule it", "is this tweet/skeet on-brand", or
  wants a post checked for voice, alt text, hashtags, image size, and whether it
  needs leadership sign-off. Loads the rules from rladies-social-posts, delegates
  the voice/inclusive-language pass to run-brand-check, and emits a structured
  Blockers / Warnings / Nits report. It does NOT post, schedule, or approve — it
  hands a human a punch list.
---

# Run: RLadies+ Social Post Review

An **action** skill that runs the [`rladies-social-posts`](../rladies-social-posts/SKILL.md)
rules against a drafted post and produces a review before it goes into Buffer. It is a
**pre-human gate** — Buffer approval and the leadership sign-off still happen; this just
catches the fixable things first. It never posts, schedules, or approves.

## Gather the draft

Ask for what's missing: the **post text** (each post if it's a thread), the target
**platform(s)**, and whether there's an **image** (and its dimensions/ratio). Platform
matters — image ratios and character limits differ.

## Leadership-review gate — BLOCKER (flag)

First and most important. Posts about **controversies, partnerships, or policy changes
must be reviewed by the leadership team before publishing.** If the draft touches any of
these, raise it as a **Blocker** at the top of the report: "Hold — needs leadership
review before scheduling." This is a routing flag, not a copy defect; surface it
prominently even if everything else passes.

## Voice & inclusive language

Delegate the text to [`run-brand-check`](../run-brand-check/SKILL.md): warm/direct
"we"/"our" voice, spotlight people and chapters over the org, **one exclamation mark
max**, 💜 signature, a clear call to action, and **"gender minorities in R"** — never
"females"/"women only". Merge its findings in.

## Social-specific checks

- **Alt text on every image — BLOCKER.** Always add alt text describing the image,
  _including any text shown in it_. A graphic with no alt is a hard fail.
- **Hashtags — NIT.** `#RLadies`, `#RStats`, plus the relevant event tag
  (`#PositConf`, `#useR`, `#LatinR`) where it fits.
- **Image ratio per platform — WARNING** if a supplied image doesn't match:

  | Platform / type           | Ratio |
  | ------------------------- | ----- |
  | Instagram feed            | 4:5   |
  | Instagram Stories / Reels | 9:16  |
  | LinkedIn                  | 1:1   |
  | Bluesky / Mastodon        | 16:9  |
  | YouTube thumbnail         | 16:9  |

- **Graphic source — NIT.** If a graphic was made, it should come from the official
  Canva Brand Templates (text/images/logos changed only, never fonts/colours/layout →
  `rladies-branded-assets`).
- **Tone per surface — NIT.** LinkedIn can be a touch more professional; Instagram is
  visual-first. Keep the voice, adjust the register.

## Amplification questions

If the ask is "should the global **@rladies** account share/retweet/like this?" rather
than "review my draft", switch to the amplify / don't-amplify rules in
`rladies-social-posts` (past events with photos/resources = yes; future in-person
chapter events, job posts, ad-like content, least-inclusive "women"-hashtag posts = no)
and answer with a recommendation + reason instead of the tiered report.

## The report

Emit the **standard tiered report** defined in
[`run-brand-check`](../run-brand-check/SKILL.md) — `## Social review: <platform> —
<verdict>`, then ⛔ Blockers / ⚠️ Warnings / 💜 Nits (location + suggested fix) and ✅
Passed, closing with the "no posting or approval" line. A pending leadership review is a
Blocker, so it forces ⛔ Blocked even when the copy is clean — that's intended.

## Related skills

- The rules this runs → `rladies-social-posts`; voice → `run-brand-check` / `rladies-brand`.
- Making the graphic/template → `rladies-branded-assets`.
- Reviewing the blog post being announced → `run-blog-review`.
