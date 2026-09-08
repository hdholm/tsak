+++
date = '2026-09-07T23:05:01-04:00'
title = 'Forwarding to GMail via API'
tags = ['software', 'tech']
+++
Google has deprecated and is soon turning off the ability to get email from
other servers via POP (and despite what you may have thought has apparently
never used IMAP.) Forwarding messages via SMTP causes all kinds of issues
including, but not limited to DKIM, SPF, and DMARC failures.  So I turned to
their API and after a little (more than I wanted) research I came up with a
modest python script to deal with it.

### gmailSender

[gmailSender](https://github.com/hdholm/gmailSender) takes email on it's
standard input, either in mbox format or a single message and sends it to
a GMail account.  You have to have API access to the account, so it's not a
way to send email, it's a way to send email from an account you have somewhere
(like a personal domain) to your own GMail account - or at least an account of
someone willing to authorize writing to their e-mail directly.

It seems that later this year Google will likely ALSO disable the ability to
send email via a remote server. So the ability to reply directly from GMail to
email that you have forwarded from another server will be eliminated. This
seems to be yet another example of [Enshitification](https://us.macmillan.com/books/9780374619329/enshittification/)
which seems to be ["The way of things"](https://pluralistic.net/2024/04/04/teach-me-how-to-shruggie/#kagi) at Google.

### Credits

- While seaching for a way to send email to Google, I found **Jeremy Ephron
  Barenholtz**'s github repository at
  https://github.com/jeremyephron/simplegmail which provided
  some insight into the gmail API and the genesis of this idea.
- **Anthropic's Claude AI** provided two proof of concept attempts that were
  close to functional and provided even more insight into the operation of the
  gmail API, but were broken in various ways.  Claude was also used to update
  to help update to the more modern EmailMessage class in python which fixed
  a number of the bugs in the previous Claude versions.
- Claude attempted to build a version that took both
  single messages and multiple message mboxen on standard input.  Unfortunately,
  it did that by using python 2's PortableUnixMailbox. But Python 3's mbox uses
  a pathname not a file-like-object. **Enrico Zini** seems to have a way
  forward around that in this blog:
  https://www.enricozini.org/blog/2019/debian/python-hacks-opening-a-compressed-mailbox/
  although it turns out reading raw bytes and then using the modern `EmailMessage`
  class with `email.policy.default` is much more straightforward and less
  fragile.
