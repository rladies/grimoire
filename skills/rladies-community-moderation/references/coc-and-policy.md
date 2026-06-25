# Community Slack policy & Code of Conduct sync

Deep reference for `rladies-community-moderation`. Sources: `community/slack`,
`global-team/code-of-conduct`.

## Who the Slack is for (verbatim)

> This Slack is for people that identify as a woman or gender minority and are interested
> in the R programming language. If you are a cis-male (you were born male, and you also
> identify as male), please do not sign up.

Rationale: RLadies+' mission is to increase gender diversity in the R community; a safe
space where underrepresented genders feel at ease helps achieve a harassment-free,
welcoming community. Distinct from the Organizers' Slack (`r-ladies.slack.com`, organizers
only). General Slack questions → `slack@rladies.org`.

## Allowed / not allowed

**Allowed:** ask and answer questions; share achievements; look for and share job
opportunities; advertise events and conferences; share #rstats news; share resources;
bring ideas for the community.

**Not allowed:** promoting commercial products (for a member discount, discuss with the
leadership team first); sharing inappropriate content — e.g. disturbing images/videos,
content promoting negative values/health risks/bad habits, false information, offensive or
mocking content.

Unsure if a post is suitable → ask `@Community Management Team` in Slack or email
`slack@rladies.org`.

## Inclusive language (verbatim)

> We would like to encourage gender-neutral language in this Slack. Please avoid
> addressing people as "ladies" or "guys". You can use expressions as "folks", "y'all",
> "everyone", "everybody", "friends" or "pals" instead.

## Code of Conduct & reporting (verbatim)

> If you are being harassed by a member/guest/participant of/at RLadies+, notice that
> someone else is being harassed, or have any other concerns, please contact the Global
> Leadership Team via `reporting@rladies.org`.

Within Slack, contact `@Community Management Team`. The CoC applies to all RLadies+ spaces
(meetups, Twitter, Slack, mailing lists, online and offline). On Slack: don't share Slack
content outside Slack without consent; avoid sexual/offensive usernames or photos.

> Participants asked to stop any harassing behaviour are expected to comply immediately. If
> a participant engages in harassing behaviour, the Global Leadership Team may take any
> action they deem appropriate, up to and including expulsion from all RLadies+ spaces …
> and identification of the participant as a harasser to other RLadies+ members or the
> general public.

## Keeping the Code of Conduct in sync (technical, lower priority)

The CoC source (including translations) lives at
<https://github.com/rladies/.github/blob/master/CODE_OF_CONDUCT.md>. A site should read it
from GitHub into a layout, show the last-build time, and link to the source. To keep it
current, create a **Netlify build hook** (a URL), store it as a repo secret, and add a line
to the rladies/.github `main.yml` workflow so every CoC update triggers a site rebuild.
**The Code of Conduct is only edited with the agreement of the global leadership.**
