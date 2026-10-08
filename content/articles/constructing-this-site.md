+++
date = '2026-09-07T12:49:08-04:00'
title = 'Constructing this Site'
description = 'Why I chose Hugo for this, removed the theme, and added static search with Pagefind.'
categories = ['tech']
tags = ['web', 'software', 'fedora']
+++
I had been considering a blog for a while, mostly to hold what I have learned
about various things. I did not want to relearn those hard-won bits of
knowledge the next time I needed them, so I kept a private collection of
notes. I also believe sharing is a good thing, and I wanted to make those
notes available to anyone who might find them useful.

## Choosing Hugo

While working with [Gramps](https://gramps-project.org/), I became aware of
one of its developers, David Straub. When he
[revamped his personal website](https://davidstraub.de/posts/my-new-website-setup/),
I learned of [Hugo](https://gohugo.io/), which met my list of criteria for a
blog system and was similar to what he described.

## Removing the theme

I started with the [Ananke](https://github.com/gohugo-ananke/ananke) theme.
I liked it, but then I came across Greg Vedders's
[Rebuilding gregvedders.com Without a Hugo Theme](https://gregvedders.com/posts/rebuilding-gregvedders-com-without-a-hugo-theme/),
which was very close to what I was already doing. I was inspired to simplify by
dropping the theme, which had added features and complexity I neither used nor
needed. With some help from ChatGPT, I reworked the site to use Hugo without an
external theme. The layouts and CSS live directly in this repository, so the
site carries only the pieces it uses.

## Adding search without a server

In that same Greg Vedder article I learned about
[Pagefind](https://pagefind.app/) and included that as well. Being able to
have search available while still maintaining a completely static site, and
thus much less complex, site is a huge benefit.

## How it fits together

- **Templates and styling.** Ordinary Hugo templates under `layouts/` and a
  small stylesheet under `assets/css/`. The
  [Hugo documentation](https://gohugo.io/documentation/) covers the templating
  and content model.
- **Search.** Pagefind builds a search index at deploy time, which provides
  search while keeping the site completely static.
- **Source.** Everything is on [GitHub](https://github.com/hdholm/tsak) if you
  want a closer look.

## Installing Hugo on Fedora

Hugo is available in the Fedora repositories (see Hugo's
[Linux installation notes](https://gohugo.io/installation/linux/) for other
options):

```sh
sudo dnf --refresh install golang hugo
```

## References

- [David Straub: My new website setup](https://davidstraub.de/posts/my-new-website-setup/)
- [Greg Vedders: Rebuilding without a Hugo theme](https://gregvedders.com/posts/rebuilding-gregvedders-com-without-a-hugo-theme/)
- [Hugo documentation](https://gohugo.io/documentation/)
- [Pagefind documentation](https://pagefind.app/docs/)
