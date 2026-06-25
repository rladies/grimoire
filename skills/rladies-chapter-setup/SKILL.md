---
name: rladies-chapter-setup
description: >-
  Start, onboard, and keep an RLadies+ chapter compliant over its lifetime (as opposed
  to running an individual event). Use this when someone wants to start a new RLadies+
  chapter, onboard or add co-organizers, set up chapter tech (the chapter email,
  Meetup, password manager / 2FA, Posit Cloud), understand the chapter rules and the
  one-event-every-6-months activity requirement, transition organizers, or retire /
  reactivate a chapter — and for the global-team side of onboarding a new chapter from
  the chapters@rladies.org inbox. For running an event use rladies-chapter-event; for
  the chapter's website JSON use rladies-website. Source: guide.rladies.org organizers
  (intro, tech, rules) and global-team (onboarding, monitoring, meetup).
---

# Starting & Running an RLadies+ Chapter

This is the chapter **lifecycle** — start, staff, keep compliant, hand over, retire.
Running a single event is `rladies-chapter-event`; the chapter's site JSON (and
retiring an organizer in it) is `rladies-website`.

## Start a chapter

Email **`chapters@rladies.org`** with who you are and where you'd like a chapter (use a
**personal** email, not work/university). The onboarding team then sets up the
**Meetup Pro account**, a **chapter email** (`yourcity@rladies.org`), an **Organizers'
Slack** invite, the **Community Slack** invite, and a **GitHub chapter data entry**
(status `prospective`). The new chapter must hold its **first event within 6 months**,
then **at least one event every 6 months**. The global-team-side onboarding workflow,
the welcome email, and Meetup creation are in
[references/onboarding-and-meetup.md](references/onboarding-and-meetup.md).

## Co-organizers

Recruit by talking to candidates directly, a "call for organizers" slide at events, and
asking on a new-member form — and aim to diversify the team; people can help unofficially
first. To **officially add** one, the current organizers email
**`chapters@rladies.org`** with the new organizer's name + email (this is the only
official route); all organizers get the Meetup **organizer** role. Don't overcommit —
share the load.

## Tech & security

The **chapter email** (`yourcity@rladies.org`, Google Workspace) is the public-facing
address and is used to create all chapter social accounts; cc it on replies so
co-organizers see them. Use a **personal password manager** (KeePass/Bitwarden/1Password)
with a strong unique master password; enable **2FA** (e.g. DuoMobile) and save recovery
codes; share chapter credentials safely (a shared KeePass DB on Drive, or 1Password's
OSS plan). **Posit Cloud** for workshops: request via the form **≥ 2 weeks ahead**
(≤ 500 MB/project). Details in
[references/lifecycle-and-tech.md](references/lifecycle-and-tech.md).

## The rules (what keeps a chapter compliant)

Events are **free**; **R-specific**; **organizer/mentor roles are held by minority-gender
people** and speakers preferably so (strong recommendation: **max one cis-male speaker
per event**); the **Code of Conduct** applies; **no commercial vehicle** (no company-run
chapters, no paid-product talks); RLadies+ keeps its **independence** from sponsors.
Publish every event on Meetup — that's what counts as activity. (Full verbatim rules:
`rladies-partnership-eval` → references; partner/sponsor vetting also lives there.)

## Keep active, transition, or retire

Chapters are **active** (event in the last 6 months or upcoming), **inactive** (none), or
**unbegun**; check status at <https://r-community.github.io/user-groups/rladies.html>.
Inactivity is reviewed quarterly: the team emails/Slacks the chapter (first a "need
help?" note, then, after ~2 weeks of no reply, a retirement notice). **Running an event
removes you from the retirement list.** If you can't continue: ask members to take over,
announce in the Community Slack, or tell the team — then update the website JSON
(`current` → `former`) and hand over account credentials. The monitoring cadence and all
the email templates (inactive, retirement, reactivation) are in
[references/lifecycle-and-tech.md](references/lifecycle-and-tech.md).

## Related skills

- Running an event (speakers, Zoom, promotion) → `rladies-chapter-event`.
- The chapter's website JSON and retiring an organizer in it → `rladies-website`.
- Sponsorship, grants, reimbursement → `rladies-funding`.
- Vetting a sponsor/partner and the full rules text → `rladies-partnership-eval`.
