---
name: run-brand-check
description: >-
  Run an automated RLadies+ brand and voice review on a piece of copy or an
  asset, as a pre-human-review gate. Use this when someone says "run a brand
  check", "review this in the RLadies+ voice", "does this pass the brand
  rules", "does this sound like AI wrote it", or wants an email / slide /
  announcement / any copy checked for voice, AI-sounding tells, inclusive
  language, accessibility, and visual identity before a person signs off.
  Loads the rules from rladies-voice and rladies-brand and emits a structured
  Blockers / Warnings / Nits report. It does NOT approve or publish — it
  hands a human a punch list. The content run-* reviews (run-blog-review,
  run-social-review, run-translation-review) delegate their brand/voice pass
  to this skill.
---

# Run: RLadies+ Brand Check

An **action** skill. Where [`rladies-brand`](../rladies-brand/SKILL.md) and
[`rladies-voice`](../rladies-voice/SKILL.md) _teach_ the brand and voice, this one
_runs_ them: you point it at copy or an asset, it evaluates every rule, and it
produces a review a human can act on. It is a **pre-human gate** — it never
approves, publishes, or merges. Load `rladies-voice` for the voice/AI-tell rules
and `rladies-brand` for naming/inclusive-language/visual-identity/accessibility;
the checklist below is the executable form of them.

## What to review

Ask for the artifact if it wasn't given: pasted text, a file path, or a described
asset (logo/graphic/slide with its colours, fonts, and layout). Note the **surface**
(social post, blog prose, email, slide, logo) — some checks only apply to some
surfaces, and the dedicated run-\* reviews layer their own checks on top.

## The checklist

Run every applicable check. Cite a **location** for each finding (line number, quote,
or the element). Map each to a tier using the severity noted.

### Inclusive language — BLOCKER

The non-negotiable core. Scan the copy for exclusionary framing:

```bash
grep -inE "\b(females?|women[- ]only|ladies[- ]only|for women\b)" <file>
```

- "females", "women only", "ladies only", "for women" → **Blocker.** RLadies+ serves
  **gender minorities in R** (cis/trans women, trans men, non-binary, genderqueer,
  agender). Rewrite so all of these readers are addressed.
- Copy that centres only one group, or reads as gatekeeping → Blocker/Warning by degree.

### Naming — WARNING

```bash
grep -nE "R-Ladies|R Ladies" <file>
```

- Hyphenated **"R-Ladies"** or "R Ladies" in prose → Warning; the written form is
  **`RLadies+`**. `rladies` (no plus) is only for handles/slugs/usernames.

### Voice — WARNING / NIT

From `rladies-voice`'s identity-level do/don'ts:

- Corporate / formal / institutional tone; over-explaining; centring the global org
  over people and chapters → **Warning.**
- **More than one exclamation mark** in the piece → Warning.
- No clear call to action where the surface expects one (social, announcement) → Nit.
- Missing the 💜 signature where it fits → Nit.

### AI-sounding tells — WARNING / NIT

From `rladies-voice`'s tell list — scan for the pattern, not just the exact phrase:

```bash
grep -inE "in today's (fast-paced|ever-evolving)|ever-evolving landscape|not just .*, it's|isn't just .*, it's|we are (beyond )?thrilled|couldn't be more excited|in conclusion|it's worth noting that|moreover,|furthermore,|don't miss out|stay tuned" <file>
```

- Stock openers, "not just X, it's Y" constructions, corporate-enthusiasm
  inflation, empty transitions ("moreover", "furthermore", "in conclusion"),
  generic CTAs ("don't miss out", "stay tuned") → **Warning.**
- Adjective triads ("innovative, dynamic, and impactful"), inspirational-poster
  adjectives ("vibrant, diverse, empowering community") standing in for a named
  person/chapter, hedging ("can potentially", "may in some cases"), bullet-itis
  (every paragraph turned into bolded-lead-in bullets), summary endings that
  recap instead of ending on the CTA → **Nit**, Warning if pervasive.
- Wall-to-wall em dashes or semicolons doing the job short sentences should → Nit.

### Accessibility — BLOCKER / WARNING

- **Any image without alt text** → **Blocker** (alt text is non-negotiable; describe
  the image _including any text shown in it_).
- Underlined / italic / **ALL-CAPS** text used for emphasis → Warning (use **bold**).
- Text not left-aligned → Warning.
- If sizes are given: text **< 6pt**, or line spacing **< 1.5** → Warning.
- If colours are given: low contrast for the text size → Warning (verify at
  <https://colourcontrast.cc>).

### Visual identity (assets only) — BLOCKER / WARNING

- Off-palette colours where brand colours are expected → Warning. Brand: Blue Violet
  `#881ef9` (main), Dodger Blue `#146af9`, Brilliant Rose `#ff5b92` (accents),
  Bastille Black `#2f2f30` / Lavender White `#ededf4` (basics, in place of pure
  black/white). Legacy purple `#88398a` / grey `#a7a9ac` → Warning: replace.
- Non-Poppins body/heading type, or non-Inconsolata monospace → Warning.
- **Logo integrity → Blocker** if the logo is edited, recoloured off-brand, rotated,
  skewed, stretched, has the R moved relative to its text, is recreated in another
  font, sits on a busy/discontinuous background, or lacks clear space.

## The report (standard format — reused by every run-\* review)

Emit exactly this shape so team members get familiar output every time:

```markdown
## Brand check: <artifact> — <verdict>

**Verdict:** ✅ Ready for human review · ⚠️ Needs changes first · ⛔ Blocked

### ⛔ Blockers (N)

Hard fails — fix before a human reviews or this goes out.

- **<location>** — <what's wrong> → <suggested fix>

### ⚠️ Warnings (N)

Brand/quality issues a human reviewer would flag.

- **<location>** — <what's wrong> → <suggested fix>

### 💜 Nits (N)

Optional polish.

- **<location>** — <suggestion>

### ✅ Passed

- <checks that passed, one line each>

---

_Automated pre-human-review pass — no approval or publish. A human still reviews._
```

**Verdict rule:** any Blocker → ⛔ Blocked. No Blockers but ≥1 Warning → ⚠️ Needs
changes first. Only Nits or nothing → ✅ Ready for human review. Never soften a
Blocker to get to green — the point is to catch it before a person does.

## Related skills

- Voice and the AI-tell patterns → `rladies-voice`; naming, inclusive language,
  visual identity, accessibility → `rladies-brand`.
- Reviewing a blog post → `run-blog-review`. A social post → `run-social-review`.
  A translation → `run-translation-review`. Each delegates its brand pass here.
