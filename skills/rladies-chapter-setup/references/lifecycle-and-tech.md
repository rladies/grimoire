# Chapter tech, security & lifecycle templates

Deep reference for `rladies-chapter-setup`. Sources: `organizers/tech` (accounts, email,
security), `organizers/intro/retiring`, `global-team/monitoring`.

## Chapter email

`yourcity@rladies.org` on Google Workspace (since Nov 2022) — created during onboarding,
no separate request. You receive a temporary password + first-login link (reset link
expires after 48h). It's the public-facing address and must be used to set up all chapter
social accounts; reply from your personal email but cc the chapter email so co-organizers
see threads.

## Security

- **Password manager** (personal): KeePass (with a Drive/Dropbox backup), Bitwarden, or
  1Password. Master password: several words long, with special characters/numbers, hard to
  guess but memorable, and **not reused anywhere**.
- **2FA** on GitHub/social accounts (e.g. DuoMobile) — save the recovery codes in your
  password manager and share with the team where relevant.
- **Sharing chapter credentials**: a dedicated chapter KeePass DB shared via Google Drive
  (each person stores the DB password in their own manager), or the
  [1Password OSS free plan](https://github.com/1Password/1password-teams-open-source).

## Posit Cloud

Request via the [Posit Cloud Request form](https://rladies.org/form/posit-cloud-request)
**≥ 2 weeks** before the event (chapter, event title/date, space admin + coordinator
names/emails, one-time vs repeat). Response within 7 days (else ping `posit-cloud` on the
Organizers' Slack); accept the invite within 7 days; recommend ≤ **500 MB** of files per
project.

## Activity & retirement

Status (at <https://r-community.github.io/user-groups/rladies.html>): **active** (event in
last 6 months or upcoming), **inactive** (none), **unbegun** (created, no events yet).
Inactivity is reviewed at the start of each quarter; retirement is expected within
~9 months–1 year of creation/last event. Cadence: email + Slack first contact → wait
~2 weeks → Slack nudge → wait ~2 weeks → retirement-notice email. **Running an event
removes the chapter from the list.** Retiring: delete the Meetup page (Meetup team), set
status `retired` in the website JSON via PR, and suspend/transfer email + social accounts
(send credentials to `chapters@rladies.org`).

**Inactive — first contact (verbatim core):**

```
SUBJECT: Your chapter has no recent activity, do you need help?

We noticed your RLadies+ chapter was created more than 6 months ago, there have been no
recent meetups and no upcoming events. Can we help? We can: team you up with an
experienced organiser via the mentoring programme
(https://rladies.org/form/mentoring-signup/); give quick advice on the organisers' slack;
or, if you no longer have time, help find someone to take over. If we don't hear from
you, we'll assume nobody is leading the chapter and schedule it to be retired.
```

**Retirement notice (verbatim core):**

```
SUBJECT: IMPORTANT, your chapter is scheduled to be retired!

We contacted you on <chapter>@rladies.org and Slack and received no answer, so we assume
you're no longer running the chapter. RLadies+ can only support chapters that run at least
one event every 6 months. Your chapter will be retired on <DATE>. Please email
chapters@rladies.org with login credentials to the chapter's email/slack/twitter/facebook
so the leadership team can close/suspend the accounts. We hope you'll join RLadies+ Remote
(https://www.meetup.com/rladies-remote/) and the Community Slack.
```

**Reactivation:** confirm current organisers, ensure access to the chapter email (check it
regularly — it's the main channel) and all chapter accounts, re-read the guidelines, then
email `chapters@rladies.org` with a plan and the next event's date/format. Transitioning to
a new organizer: email `chapters@rladies.org`, update the website JSON (`current` →
`former`), and the new contact gets Organizers' Slack access.
