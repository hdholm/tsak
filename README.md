# The Solutions Are Known

Notes on technical (and other) solutions, built with [Hugo](https://gohugo.io/)
without an external theme, searched with [Pagefind](https://pagefind.app/), and
deployed by `.github/workflows/deploy.yml` on push to `main`.

```sh
hugo server -D            # local preview
hugo build --minify       # production build into public/ (git-ignored)
npx -y pagefind@1.5.2 --site public   # search index; the deploy workflow does this
```

New article: `hugo new content articles/my-title.md`, then fill in `description`.
Use lowercase tags, and keep categories to a few broad buckets.

Optional front matter for policy articles:

- `series_order = N` puts the article in the Public Policy series (shown on
  `/categories/public-policy/`, with Previous/Next links in that order).
- `lastreviewed = 2026-10-14` shows a "Last reviewed" date; update it when the
  article is reviewed for current information.
- `toc = false` hides the table of contents that long articles (over 1,500
  words) get automatically.
- Figures: `![alt text](image.svg "Caption")` renders as `<figure>` with the
  title as its `<figcaption>`.

## Link checking

[![Check Links](https://github.com/hdholm/tsak/actions/workflows/linkcheck.yml/badge.svg)](https://github.com/hdholm/tsak/actions/workflows/linkcheck.yml)

The site deploys under `/tsak/`, so build into a `tsak/` directory and point
[lychee](https://lychee.cli.rs/) at the parent as its root:

```sh
hugo build --destination _site/tsak
lychee --config lychee.toml --offline --root-dir "$PWD/_site" \
  --remap "https://holmgrown.com/tsak/ file://$PWD/_site/tsak/" _site/tsak   # internal only
# drop --offline to check external links too
```

`.github/workflows/linkcheck.yml` runs the offline check on every push and pull
request, and the full check weekly. Add `-D` to the build to also check drafts.
