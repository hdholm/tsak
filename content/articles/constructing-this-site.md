+++
date = '2026-09-07T12:49:08-04:00'
title = 'Constructing this Site'
tags = ['web', 'software', 'tech', 'fedora']
+++
I had been considering a blog site for a while, mostly to hold information about
things I've spent energy learning. I didn't want to have to relean those hard
fought bits of knowledge the next time I needed them so I had a private
collection of notes. By nature, I believe sharing is a good thing, and wanted
to make those bits of knowledge available to anyone else who might find them
useful.

In working with [Gramps](https://gramps-project.org/) I was aware of one of the
developers, David Straub, and when he [revamped his personal website](https://davidstraub.de/posts/my-new-website-setup/)
I learned of [Hugo](https://gohugo.io/) which met my list of criteria for a
system to maintain a blog, which was somewhat similar to Dr. Straub's.  I
initially utilized the [Ananke](https://github.com/gohugo-ananke/ananke) theme.
While I liked that theme, I stumbled on
[Rebuilding gregvedders.com Without a Hugo Theme](https://gregvedders.com/posts/rebuilding-gregvedders-com-without-a-hugo-theme/)
which was very close to what I was doing already.  I learned about Pagefind
there and was inspired to also simplify what I was doing by removing the theme,
which while nice, added a lot of features and complexity I wasn't using and
didn't need. So with a little help from ChatGPT I reworked the site to
use Hugo without an external theme.  The layouts and CSS are kept directly
in this repository so the site only carries the pieces it actually uses.

The site uses ordinary Hugo templates under `layouts/` and a small stylesheet
under `assets/css/`. See the [Hugo documentation](https://gohugo.io/documentation/)
for the templating and content model.

I added [pagefind](https://pagefind.app/) which provides a search index while
still maintaining a static site.  Everything is available on [GitHub](https://github.com/hdholm/tsak)
for anyone wanting a closer look at the details

Hugo is available in the Fedora repos
```
sudo dnf --refresh install golang hugo
```
