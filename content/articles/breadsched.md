+++
date = '2026-09-08T15:32:15-04:00'
title = 'BreadSched'
description = 'A personal cash-flow budgeting and projection tool, written in Python, that imports GnuCash data.'
categories = ['tech']
tags = ['finance', 'software']
+++

## GNUcash is Great for Many Things

For a long while I have used [GnuCash](https://www.gnucash.org/) and some
spreadsheets to manage my finances. GnuCash has excellent features for
tracking income, expeses, assets, liabilities as well as business
accounting features (invoices, receivables, and so on) that would be useful
for an LLC but that I do not need for my household. It is not especially
helpful, though, for projecting cash flow or making long-term projections. So I
kept spreadsheets for that, plus a dashboard-style spreadsheet to track my
overall current financial picture.

## BreadSched is Born

Now that I no longer have a demanding day job, and AI-assisted coding has
become good enough to be useful, I am building an application designed for
my specific desires in a financial applicaiton.  My initial requirements were:

- Written in [Python](https://www.python.org/), the language I am most
  comfortable with.
- Both a [GTK](https://www.gtk.org/) interface and a web interface, so it works
  locally on Linux but can also be self-hosted, which will, I hope, eventually
  let me easily add transactions from a phone.
- Budgets and long-term projections that can be saved and altered to test
  different assumptions.
- Budgeting and projections driven by known scheduled transactions as well as
  scheduled estimates.
- Import of a GnuCash data file, since I have a lot of history in that data.

## Current State

BreadSched is about 77,000 lines of Python, about 5,900 lines of JavaScript,
and about 50,000 lines of tests (over 2,000 test functions). But it is still
what I would consider "Alpha" state software and I wouldn't count on
it for day-to-day use.  It does have most of the functionality I want and it
continues to improve. The code and releases are freely available in a
[GitHub repo](https://github.com/hdholm/BreadSched/). The primitive installers
aren't signed yet and the best way to keep up is probably with a Python
development environment.  So I wouldn't recommend it for anyone without a little
bit of technical skill yet.  But that said, feedback at this point is very much
welcome.

- [BreadSched project overview](https://github.com/hdholm/BreadSched/blob/main/README.md)
- [BreadSched user guide](https://github.com/hdholm/BreadSched/blob/main/src/breadsched/USER_GUIDE.md)
- [BreadSched roadmap](https://github.com/hdholm/BreadSched/blob/main/ROADMAP.md)

