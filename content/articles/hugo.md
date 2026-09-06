+++
date = '2026-09-05T23:49:08-04:00'
title = 'Hugo'
tags = ['web', 'software', 'tech', 'fedora']
+++
This site was created with [Hugo](https://gohugo.io/) utilizing the
[Ananke](https://github.com/gohugo-ananke/ananke) theme.  While I like that
theme, I stumbled on [Rebuilding gregvedders.com Without a Hugo Theme](https://gregvedders.com/posts/rebuilding-gregvedders-com-without-a-hugo-theme/)
which was very close to what I was doing already and wanted as a site feel. So
taking a cue from that and with a little help from ChatGPT reworked the site to
use Hugo without an external theme.  The layouts and CSS are kept directly
in this repository so the site only carries the pieces it actually uses.
Hugo is available in Fedora
```
sudo dnf --refresh install golang hugo
```
The site uses ordinary Hugo templates under `layouts/` and a small stylesheet
under `assets/css/`. See the [Hugo documentation](https://gohugo.io/documentation/)
for the templating and content model.
