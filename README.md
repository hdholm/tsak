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
