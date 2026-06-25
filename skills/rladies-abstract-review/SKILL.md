---
name: rladies-abstract-review
description: >-
  Coordinate the RLadies+ abstract review service — matching conference-abstract and
  funding-application feedback requests from women and gender minorities to volunteer
  reviewers, and tracking them in Airtable. Use this when handling an incoming abstract
  review request, assigning or chasing reviewers, drafting the reviewer invitation,
  updating the abstracts/volunteers/tasks tables, onboarding a new review volunteer, or
  giving guidance on writing supportive abstract feedback. Source: guide.rladies.org
  community/abstract-review and global-team/airtable/abstract-review.
---

# RLadies+ Abstract Review

RLadies+ Global runs a system for reviewing conference abstracts and funding
applications — for both R-related and domain-specific conferences. The goal is to
encourage women and other gender minorities to submit proposals and improve their
chances, with international reviewers giving constructive feedback on **topic and pitch,
phrasing, and subject matter**. Requesters are asked to submit **no later than three
weeks before** their conference deadline.

## The two intake forms

- **Request feedback** → <https://rladies.org/form/abstract-request/> — populates the
  `abstracts` table, posts to Slack, creates a `tasks` record, and emails
  `abstract-review@rladies.org`.
- **Volunteer to review** → <https://rladies.org/form/abtract-volunteer/> (the typo in
  the slug is in the live form) — populates the `volunteers` table and pings Slack.

Coordination happens in the **`#team-abstract_review`** Slack channel. Volunteers decide
how to share the load — e.g. alternating who handles requests each month.

## Handling a request (coordinator workflow)

1. **Check the request** — submission deadline, the requester's preferred reviewer
   language and gender, their comments, and that any attached document is accessible.
2. **Pick reviewers from the `volunteers` table**, favouring people who haven't done too
   many recent reviews; **increment their "Reviews requested" by 1.**
3. **Email ~3 potential reviewers** using the template below.
4. **Check in regularly** so nothing stalls — see whether the reviewer has added
   comments to the doc; **if they don't respond to the initial email, assign a new
   reviewer.**
5. **Update the `abstracts` table** — `Status` and `Reviewer 1` / `Reviewer 2` /
   `Reviewer 3`.
6. **Update the `volunteers` table** — `Reviews requested` and `Reviews completed`.

## Reviewer invitation template

```
Hi <reviewer name>!

Thank you so much for offering to review abstracts through the RLadies+ review program! We received a request earlier and I wondered if you'd have time in the next week or so to take a look?  The conference deadline is <date>.

If you do, the link is <here - add link>, and I think you should be able to leave comments directly in the doc. If now isn't a good time, totally understand - just let us know so we can assign a new reviewer!

Thanks!

<your name>
```

The tone is deliberate — warm, low-pressure, easy to decline. Keep it that way: the
service exists to **encourage** gender minorities to put their work forward, so feedback
should be constructive and supportive, never gatekeeping.

## Airtable structure

Base: <https://airtable.com/appJadVolZxoDGSIK>. Three linked tables — `abstracts`
(requests), `volunteers` (reviewers, with the `Reviews requested` / `Review completed`
counters), and `tasks` (the per-request review with `Reviewer 1/2/3` and their statuses).
The full field catalog and the Slack/stale-request automations are in
[references/airtable.md](references/airtable.md).

## Related skills

- Inclusive, supportive framing → `rladies-brand`.
- Broader conference participation / speaker support is a separate organizer workflow.
