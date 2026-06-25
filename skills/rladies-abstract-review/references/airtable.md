# Abstract review: Airtable structure & automations

Deep reference for `rladies-abstract-review`. Source:
`global-team/airtable/abstract-review` and `community/abstract-review`.

Base: <https://airtable.com/appJadVolZxoDGSIK>. Three tables: `volunteers`, `abstracts`,
`tasks`.

## `volunteers` table

Populated by the "Join the RLadies+ Abstract Review Team" form.

Fields: `name`, `comments`, `email`, `slack`, `review_type`, `help_type`,
`help_type_other`, `languages`, `language_other`, `Gender`, `abstracts` (link to
abstracts), **`Reviews requested`**, **`Review completed`**, `Email consent`.

The two counter fields are how load is balanced — increment `Reviews requested` when you
ask someone, and `Review completed` when they finish.

## `abstracts` table

Populated by the "Request Feedback for Your Abstract" form; links to `tasks`.

Fields: `name`, `email`, `conf_url`, `conf_name`, `conf_deadline`, `conf_type`,
`conf_type_other`, `abstract_type`, `abstract_url`, `comments`, `Reviewer Preferences`,
`Email consent`, `Are you a woman or me…` (gender-minority confirmation), `Tasks` (link),
`Status (from Tasks)` (lookup).

Coordinator updates here: **`Status`**, **`Reviewer 1`**, **`Reviewer 2`**, **`Reviewer 3`**.

## `tasks` table

Fields: `Record`, `Abstract` (link), `Conf Deadline`, `Status`, `Status last updated`,
`Reviewer 1 Status`, `Reviewer 2 Status`, `Reviewer 3 Status`, `Reviewer 1` /
`Reviewer 2` / `Reviewer 3` (each linked to `volunteers`).

## Automations

- **Volunteer Notify Slack** — on volunteer sign-up, posts to the Slack channel.
- **New Request** — on an abstract request, posts to Slack, creates a `tasks` record,
  and emails `abstract-review@rladies.org`.
- **Check stale requests** — acts on records matching staleness conditions (the trigger
  for chasing un-actioned requests).
