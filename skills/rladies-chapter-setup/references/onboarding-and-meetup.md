# Chapter onboarding & Meetup setup (global-team side)

Deep reference for `rladies-chapter-setup`. Sources: `global-team/onboarding`,
`global-team/meetup`, `organizers/intro/get-started`, `co-organizers`.

## Onboarding a new chapter (from chapters@rladies.org)

Monitor **`chapters@rladies.org`** (forwarded to onboarding-team members; ideally daily,
especially around conferences). For each request you need: city/region/country, and
organizer name(s) + email(s).

1. Search [data/chapters](https://github.com/rladies/rladies.github.io/tree/main/data/chapters)
   to confirm the city has no chapter yet (if it does, check organizer names match; if a
   nearby chapter exists, connect them by cc'ing that chapter's email).
2. Confirm mission alignment — ask them to reply "ok" to _"Do you identify as a woman or
   gender minority, and are you interested in the R programming language?"_ (just an ok —
   no personal data collected).
3. Add the chapter to the website data (city, region, country, organisers, **status
   Prospective** — no email address) via a PR; request review from `rladies/leadership`,
   then the PR author merges once approved and CI passes.
4. Invite organisers to the **Community Slack**, and to the **Organizers' Slack** once
   they fill in the RLadies+ Organizers form.
5. In the onboarding issue, mention **`@rladies/email`** and **`@rladies/meetup-pro`** to
   create the chapter's email and Meetup page.

**Welcome email (Appendix A, verbatim core):**

```
Hi <<first name>>!

It's great to hear that you are interested in starting RLadies+ <<city chapter>>!

We have some information on starting a local chapter here: https://guide.rladies.org/

We also have a Slack group which I'll send you an invitation to in a minute. Once you
join, please say hello in the #welcome channel. When you are ready to launch your chapter
and start advertising on social media, please go to #new_chapters and ask:
- The meetup team to set up a new meetup page for you,
- The email team to create a chapter email address (you'll need this to set up social
  media accounts).

There is no specific time frame for launching. Once your chapter launches on meetup.com,
please hold your first event within the next 6 months. After that, keep your chapter
active with at least one event every 6 months. Many chapters do an event every 2-3
months. If you find yourself struggling with this frequency, please be in touch and we'll
figure something out.

Welcome!
<YOUR NAME HERE>, RLadies+ Global Team
```

## Adding co-organizers / retiring an organizer (global-team side)

- **New organizers (existing chapter):** open an "existing-chapter-update" issue; send the
  Organizers form; invite to Community + Organizers Slack; ask Meetup + Email teams to
  update infrastructure; ask the Website team to add them.
- **Retiring an organizer:** ask the Meetup team to change their role to **member**; move
  them from `current` to `former` in the website chapter JSON.

## Creating the Meetup page

Monitor `@rladies/meetup-pro` notifications. Create the group: Hometown (City, country);
Category **Technology or Data Science**; Name **"RLadies+ City"** (URL
`meetup.com/rladies-cityname`, hyphens for multi-word cities — don't change the name/URL
later); paste the standard description (below); set the member label "RLadies+", topics
"R Project for Statistical Computing" + "Data Science using R", and the RLadies+
Mastodon/LinkedIn links. The organiser must **join the group** so you can promote them to
**co-organiser** (members list → ⋯ → Change member role → co-organiser). Post the Meetup
URL back in the onboarding issue. **No cis-men as co-organisers.** For city-name issues or
reactivations, liaise with the Meetup Pro account manager (email on the new-chapters repo
wiki).

**Standard Meetup description (verbatim):**

> This is a local chapter of RLadies+ Global (https://www.rladies.org), an organisation
> that promotes gender diversity in the R community worldwide. We meetup in person or
> virtually to learn about the R programming language, algorithms and advanced tools.
>
> RLadies+ welcomes members of all R proficiency levels, whether you're a new or aspiring
> R user, or an experienced R programmer interested in mentoring, networking & expert
> upskilling. Our community is designed to develop our members' R skills & knowledge
> through social, collaborative learning & sharing. Supporting minority identity access
> to STEM skills & careers, the Free Software Movement, and contributing to the global R
> community!
>
> We are pro-actively inclusive of queer, trans, and all minority identities, with
> additional sensitivity to intersectional identities. Our priority is to provide a safe
> community space for anyone identifying as a minority gender who is interested in working
> with R. As a founding principle, there is no cost or charge to participate in any of our
> RLadies+ communities around the world. You can access our presentations, R scripts, and
> Projects on our Github account (https://github.com/rladies) and follow us on Mastodon
> (https://hachyderm.io/@RLadiesGlobal) to stay up to date about RLadies+ news!
>
> Make sure you read and comply with our code of conduct (https://rladies.org/coc/) and
> community guidelines (https://guide.rladies.org/about/mission/#r-ladies-rules--guidelines).
>
> Please note that by taking part in an RLadies+ event you grant the community organizers
> full rights to use the images resulting from the photography/video filming/media … If
> you do not wish to be recorded in these media please inform a community organizer.

Organizers may translate/adapt it, but must keep the mission, the CoC link, and the
photography notice, and must not change the group name or URL.
