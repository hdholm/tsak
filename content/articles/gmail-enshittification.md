+++
date = '2026-09-06T01:35:21-04:00'
title = 'Gmail Enshittification'
description = 'Why Google removing POP fetching and send-as from Gmail breaks email for people who use their own domains.'
aliases = ['/articles/gmail-enshitification/']
categories = ['tech']
tags = ['email', 'google', 'enshittification']
+++
Google long ago dropped "Don't be evil" from its
[code of conduct](https://en.wikipedia.org/wiki/Don%27t_be_evil), which I take
to mean it no longer pretends to avoid it. We have watched Google
[enshittify](https://pluralistic.net/2023/01/21/potemkin-ai/#hey-guys) its
search engine, and now it is working on Gmail.

<!-- TODO: add a link to the article about Google Search that the original
     draft referred to as "ref article". -->

## The way things were

It was (and for the moment still is) possible to set up a Gmail account to
fetch mail periodically from a remote POP server and to "send as" a particular
identity through a remote SMTP server. You could run a mail server for
`your.example.com`, read what it received from your Gmail account, and reply
from Gmail with the message originating from your domain's server, so
[SPF](https://www.rfc-editor.org/rfc/rfc7208),
[DKIM](https://www.rfc-editor.org/rfc/rfc6376), and
[DMARC](https://www.rfc-editor.org/rfc/rfc7489) all worked correctly.

It was not perfect. "Periodically" meant the delay between a message arriving
at your server and appearing in Gmail could be arbitrarily long, often 5 to 15
minutes. The alternative, having your domain server forward mail to Gmail,
typically breaks SPF, DKIM, and DMARC, and it risks Gmail classifying your
server as a spam source, because you are forwarding (to yourself) the spam your
domain receives.

## They made it worse

Google announced it was removing the POP fetching service. You can still
forward mail to your Gmail account, but that has all the problems described
above. That led me to write
[gmailSender](https://github.com/hdholm/gmailSender), which uses the
[Gmail API](https://developers.google.com/gmail/api/reference/rest/v1/users.messages/import)
to insert mail directly into your account from a domain server. It is
described in [Forwarding to Gmail via API]({{< relref "forwarding-to-gmail-via-api" >}}).
It can be fairly involved to set up. I have tried to make the README clear, but
it still takes some technical knowledge to get gmailSender working for a given
domain.

<!-- TODO: link Google's announcement of the POP/Gmailify change. -->

## They really made it worse

It has become apparent that Gmail intends, in the near future, to remove not
only POP fetching but also the send-as ability. You will no longer be able to
use Gmail to reply to mail received at another domain *as* that domain. Your
mail will come from Gmail, and unless you use a gmail.com address or host all
your domain's mail on Google, you will break SPF, DKIM, and DMARC alignment.

<!-- TODO: link Google's announcement of the send-as / SMTP change and its date. -->

## Why do this?

We can only speculate. The stated reason is that maintaining these services is
too costly, but it is telling that Google is not providing them even to *paid*
accounts. So Google believes people will keep paying even as services they have
relied on for years disappear, which is more or less the definition of
[enshittification](https://us.macmillan.com/books/9780374619329/enshittification/).
Lock-in is probably also a factor. If your domain and all your mail services
must be hosted at Google, it is harder to switch providers, and all your email
is available on Google's servers for its AI training and advertising
businesses. If you are not paying, you are the product. With Google, even if
you are paying, you may still be the product.
