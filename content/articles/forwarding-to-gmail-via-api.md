+++
date = '2026-09-07T23:05:01-04:00'
title = 'Forwarding to Gmail via API'
description = 'gmailSender, a small Python tool that inserts mail from your own domain directly into Gmail through the API.'
categories = ['tech']
tags = ['software', 'email', 'python']
+++
Google is deprecating, and will [soon turn off](https://support.google.com/mail/answer/16604719),
Gmail's ability to fetch mail from other servers via POP. (Despite what you may
have thought, Gmail has apparently never supported fetching over IMAP.) In
an update, covered in the link above, Google has extended this deprecation to
it's *send-as* feature as well.  So while this tool will still work, it won't
be possible to use your Gmail account as your primary interface to reading and
*responding* to email at another domain.
Forwarding by SMTP is not a good substitute: forwarded messages commonly fail
[SPF](https://www.rfc-editor.org/rfc/rfc7208),
[DKIM](https://www.rfc-editor.org/rfc/rfc6376), and
[DMARC](https://www.rfc-editor.org/rfc/rfc7489) checks, because the forwarding
server is no longer an authorized sender for the original domain. (The
[ARC](https://www.rfc-editor.org/rfc/rfc8617) protocol exists to soften this,
but it depends on the receiving side trusting you.) So I turned to Gmail's API,
and after a little more research than I wanted, I wrote a modest Python script.

In [an updatex](https://support.google.com/mail/answer/17101213)
Google has extended this [enshittification]({{< relref "gmail-enshittification" >}}) to
it's *send-as* feature as well.  So while this tool will still work, it won't
be possible to use your Gmail account as your primary interface to reading and
*responding* to email at another domain.
## gmailSender

[gmailSender](https://github.com/hdholm/gmailSender) reads email on standard
input, either as a single message or in mbox format, and inserts it into a
Gmail account using the
[Gmail API](https://developers.google.com/gmail/api/reference/rest/v1/users.messages/import).
You need API access to the destination account, so this is not a way to send
email to anyone. It is a way to deliver mail you receive somewhere else, such
as on a personal domain, into your own Gmail account, or into the account of
someone willing to authorize writing to their mailbox directly.

Later this year Google will likely also disable sending mail through a remote
server ("send mail as"). Once that happens you will no longer be able to reply
from Gmail as an address hosted elsewhere. This is yet another example of
[enshittification](https://us.macmillan.com/books/9780374619329/enshittification/),
which seems to be ["the way of things"](https://pluralistic.net/2024/04/04/teach-me-how-to-shruggie/#kagi)
at Google. I wrote more about that in
[Gmail Enshittification]({{< relref "gmail-enshittification" >}}).

## Credits

- While searching for a way to get mail into Google, I found Jeremy Ephron's
  [simplegmail](https://github.com/jeremyephron/simplegmail) repository, which
  gave me some insight into the Gmail API and was the genesis of this idea.
- Anthropic's Claude produced two proof-of-concept attempts that were close to
  working and taught me more about the Gmail API, but were broken in various
  ways. Claude also helped move the code to Python's more modern
  [`EmailMessage`](https://docs.python.org/3/library/email.message.html)
  class, which fixed several bugs in the earlier versions.
- Claude also tried to build a version that accepted both single messages and
  multi-message mboxes on standard input. It did so with Python 2's
  `PortableUnixMailbox`, but Python 3's
  [`mailbox.mbox`](https://docs.python.org/3/library/mailbox.html) takes a
  path, not a file-like object. Enrico Zini has a way around that in
  [Python hacks: opening a compressed mailbox](https://www.enricozini.org/blog/2019/debian/python-hacks-opening-a-compressed-mailbox/).
  In the end, reading raw bytes and parsing them with `EmailMessage` and
  [`email.policy.default`](https://docs.python.org/3/library/email.policy.html)
  turned out to be much more straightforward and less fragile.
