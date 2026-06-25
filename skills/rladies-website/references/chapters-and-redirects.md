# Chapter JSON & redirects

Deep reference for `rladies-website`. Sources: `website/chapter`, `website/organizers`,
`website/admin_guide/redirects`.

## Chapter JSON

File: `data/chapters/<country-state-city>.json` (lowercased, dashes, no special chars;
drop the state segment if there's none, e.g. `algeria-algiers.json`). The filename is the
URL slug. Validated by `check-jsons` against
[`scripts/json_shema/chapter.json`](https://github.com/rladies/rladies.github.io/blob/main/scripts/json_shema/chapter.json).

```json
[
  {
    "urlname": "rladies-Algiers",
    "status": "prospective",
    "country": "Algeria",
    "city": "Algiers",
    "social_media": {
      "meetup": "rladies-Algiers",
      "email": "algiers@rladies.org"
    },
    "organizers": {
      "current": ["Kamila Benadrouche", "Lounas Fairouz"],
      "former": []
    }
  }
]
```

- **`urlname`** — the meetup.com identifier; used to fetch event data from the meetup
  archive.
- **`status`** — `prospective` | `active` | `inactive`. **Only `active` shows on the world
  map.**
- **`country`/`state.region`/`city`** — position on the map and grouping; `country` must
  match an entry in `data/continents.yaml`.
- **`social_media`** — omit unused keys entirely (don't leave empty). Supported keys:
  `twitter`, `github`, `instagram`, `youtube` (`channel/UC…` or `user/name`), `tiktok`,
  `periscope`, `researchgate`, `website` (full URL), `linkedin`, `facebook`, `orcid`,
  `meetup`, `mastodon` (`@user@server`), `bluesky` (`handle.bsky.social`), `slack` (invite
  URL).
- **`organizers.current` / `former`** — names; the page shows both as tabs.

Optional chapter image: `assets/chapters/<same-name>.(png|jpg|webp)`; missing image just
renders without it (build doesn't fail).

**Create via GitHub UI**: data/chapters → Add file → Create new file →
`country-state-city.json` → paste/fill → "Create a new branch and start a pull request".
After merge, the next production build adds it to the list + map, and the meetup
integration starts polling `urlname` for events.

**Retire an organizer** (`website/organizers`): change their meetup.com role from
organiser to **member**, and **move** their name from `organizers.current` to `former` —
do **not** delete it; `former` is kept as recognition.

## Redirects

A redirect is a frontmatter-only markdown file (no body):

```yaml
---
title: "RLadies+ Posit::Conf 2024 meetup"
type: redirect
redirect: https://app.sli.do/event/some-event-id
---
```

- `type: redirect` selects the redirect layout (a small submark, a one-line
  "Redirecting…", a fallback button, then `window.location.replace()` after ~2s).
- `redirect:` is the destination; `title:` shows briefly and in the title bar.
- **Query strings pass through** — `rladies.org/form/blog-post?prefill_name=Mo` →
  `<airtable-url>?prefill_name=Mo`.
- **Location**: form redirects in `content/form/` (one file per form, named for it:
  `content/form/blog-post.md` → `rladies.org/form/blog-post`); one-offs at the content
  root (`content/positconf24.md` → `rladies.org/positconf24`).
- **`aliases: [...]`** lets the same page resolve from legacy URLs:

  ```yaml
  ---
  title: "RLadies+ Directory form"
  type: redirect
  redirect: https://airtable.com/appzYxePUruG9Nwyg/pagF4TCWTbkjfuyLn/form
  aliases:
    - /directory/update/
    - /directory-update/
  ---
  ```

- **Discipline**: always share the `rladies.org/...` URL, never the underlying
  Airtable/Slido link — the destination is the implementation, the pretty URL is the
  contract. Scaffold with `hugo new --kind redirect form/awesome-thing.md`.
