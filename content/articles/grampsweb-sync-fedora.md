+++
date = '2026-09-06T01:20:21-04:00'
title = 'Using Grampsweb Sync on Fedora'
categories = ['tech']
tags = ['geneaology', 'gramps', 'grampsweb', 'software', 'fedora']
+++
When using [Grampsweb Sync](https://www.grampsweb.org/administration/sync/)
on Fedora's GNOME desktop to keep [Gramps](https://gramps-project.org/blog/)
and a [GrampsWeb](https://www.grampsweb.org/) tree in sync it is helpful for
the GNOME password manager to remember the password. Unfortunately, this is
not entirely straightforward.  You need to install python3-keyring to allow
saving of grampsweb sync password, but it defaults to using kwallet even if
GNOME is the default desktop. This is documented in
[this bug](https://github.com/jaraco/keyring/issues/496). This requires
the following workaround:

1. Make sure the Python packages secretstorage and python3-keyring are installed.
2. Create the configuration file ~/.config/python_keyring/keyringrc.cfg to
   set the default keyring to keyring.backends.SecretService.Keyring

```sh
sudo dnf --refresh install python3-secretstorage python3-keyring
sudo echo > ~/.config/python_keyring/keyringrc.cfg <<EOF
[backend]
default-keyring=keyring.backends.SecretService.Keyring
EOF
```
This has now been documented on the Grampsweb Sync installation instructions
so hopefully this article is already obsolete.
