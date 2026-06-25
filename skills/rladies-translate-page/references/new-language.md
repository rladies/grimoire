# Registering a new language & i18n-check reference

Deep reference for `rladies-translate-page`. Sources: `website/mulit-lingual/new`,
`website/mulit-lingual` overview, `website/admin_guide/gha`.

## File convention

Every translated content file is `index.<lang>.md` or `_index.<lang>.md`, sitting in
the same page-bundle folder as the English source (`index.en.md` / `_index.en.md`). The
two-letter code must match the code registered in `languages.yaml`. Renaming a content
directory renames it for every language at once — one folder, multiple `index.<lang>.md`.

Currently supported: `en` (source), `es`, `pt`, `fr`. Production exposes only English;
the others are held back by `disableLanguages: ["fr", "pt", "es"]` in
`config/production/hugo.yaml`.

## Adding a new language (five steps)

1. **Register it with Hugo** in `config/_default/languages.yaml`:

   ```yaml
   it:
     params:
       languageName: "Italiano"
       weight: 5
       description: "RLadies+ è un'organizzazione mondiale per promuovere la diversità di genere nella comunità R"
   ```

   `weight` orders the language picker; `description` is the home-page meta description.
   To translate the URL slugs too, add a `menus` entry (French does this:
   `/events/` → `/evenements/`); most languages leave slugs in English and just
   translate labels via i18n.

2. **Copy and translate the i18n strings:**

   ```bash
   cp i18n/en.yaml i18n/it.yaml
   ```

   Translate the right-hand value of every key; keep the keys in English and the YAML
   indentation intact. This drives every menu label, button, and form label (a few
   hundred lines). A partial file is fine — Hugo falls back to English for untranslated
   keys, and i18n-check lists what's missing.

3. **Add the "Read in" badge label** in `data/read_in_lang.yaml`:

   ```yaml
   it: "Leggi in italiano"
   ```

4. **Add localized month names:**

   ```bash
   cp data/months/en.yaml data/months/it.yaml
   ```

   Translate each month so dates render in prose as "12 Giugno 2026".

5. **Decide production exposure** — a new language is not live until you remove its code
   from `disableLanguages` in `config/production/hugo.yaml`. Leave it in while content is
   mostly auto-generated; remove it once enough pages are reviewed to be useful to a
   native speaker. There's no fixed threshold — discuss with the translation team.

Open one PR with all the files, tag
[@rladies/translation](https://github.com/orgs/rladies/teams/translation), and click
through the build preview to confirm the picker, translated menus, auto-translated
content, and date formatting. A team member merges; the language shows in local
previews immediately and in production once `disableLanguages` is updated.

## `i18n-check.yaml`

Two checks in one workflow: that every key in `i18n/en.yaml` exists in each
`i18n/<other>.yaml`, and that every changed content directory has a translation file for
every supported language (`LANGS="en es pt fr"`, base `en`). It posts an **"i18n
Coverage"** PR comment listing missing keys and files. It **does not fail the build** —
`missing_translations.R` fills placeholders at build time — it just surfaces the gap for
reviewers.
