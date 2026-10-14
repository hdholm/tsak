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

## Link checking

[![Check Links](https://github.com/hdholm/tsak/actions/workflows/links.yml/badge.svg)](https://github.com/hdholm/tsak/actions/workflows/links.yml)

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
