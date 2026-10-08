+++
date = '2026-09-06T01:20:21-04:00'
title = 'Using Gramps Web Sync on Fedora'
description = 'Making Gramps Web Sync store its password in the GNOME keyring on Fedora by configuring Python keyring.'
categories = ['tech']
tags = ['genealogy', 'gramps', 'gramps-web', 'software', 'fedora']
+++
When using [Gramps Web Sync](https://www.grampsweb.org/administration/sync/) on
Fedora's GNOME desktop to keep [Gramps](https://gramps-project.org/blog/) and a
[Gramps Web](https://www.grampsweb.org/) tree in sync, it helps to let the
GNOME password manager remember the password. That is not entirely
straightforward. You need the Python
[keyring](https://keyring.readthedocs.io/) library to save the sync password,
but it defaults to the KWallet backend even when GNOME is the default desktop.
This is tracked in [this bug](https://github.com/jaraco/keyring/issues/496).

The workaround:

1. Install `python3-keyring` and `python3-secretstorage`.
2. Create `~/.config/python_keyring/keyringrc.cfg` to make the
   [Secret Service](https://specifications.freedesktop.org/secret-service-spec/latest/)
   backend (which GNOME Keyring implements) the default, as described in the
   keyring documentation on
   [configuring a backend](https://keyring.readthedocs.io/en/latest/#configuring).

```sh
sudo dnf --refresh install python3-secretstorage python3-keyring
mkdir -p ~/.config/python_keyring
cat > ~/.config/python_keyring/keyringrc.cfg <<'CFG'
[backend]
default-keyring=keyring.backends.SecretService.Keyring
CFG
```

Run the `mkdir` and `cat` commands as your own user, not with `sudo`, since the
file belongs in your home directory.

This is now documented in the Gramps Web Sync installation instructions, so
with luck this article is already obsolete.
