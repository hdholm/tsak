+++
date = '2026-09-08T15:32:15-04:00'
title = 'BreadSched'
description = 'A personal cash-flow budgeting and projection tool, written in Python, that imports GnuCash data.'
categories = ['tech']
tags = ['finance', 'software']
+++

## GNUcash is really good, but

For a long while I have used [GnuCash](https://www.gnucash.org/) and some
spreadsheets to manage my finances. GnuCash has excellent features for
business accounting (invoices, receivables, and so on) that would be useful
for an LLC but that I do not need for my household. It is not especially
helpful, though, for projecting cash flow or making long-term plans. So I
kept spreadsheets for that, plus a dashboard-style spreadsheet to show the
current financial picture.

## BreadSched emarges

Now that I no longer have a demanding day job, and AI-assisted coding has
become good enough to be useful, I am building an application for my specific
needs.  My initial requirements were:

- Written in [Python](https://www.python.org/), the language I am most
  comfortable with.
- Both a [GTK](https://www.gtk.org/) interface and a web interface, so it works
  locally but can also be self-hosted, which would eventually let me add
  transactions from a phone.
- Budgets and long-term projections that can be saved and altered to test
  different assumptions.
- Budgeting and projections driven by known scheduled transactions as well as
  scheduled estimates.
- Import of a GnuCash data file, since I have a lot of history in that data.

## Current State

BreadSched is still in what I would call "Alpha" state and I wouldn't count on
it for day-to-day use.  But it has most of the functionality I want and it
continues to improve. The code and releases are available in a
[GitHub repo](https://github.com/hdholm/BreadSched/). The primitive installers
aren't signed yet and the best way to keep up is probably with a python
development environment.  So I wouldn't recommend it for anyone without a little
bit of technical skill yet.  But that said, feedback at this point is very much
welcome.
