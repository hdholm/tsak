+++
date = '2026-09-08T00:05:01-04:00'
title = 'Decrypting Disks without Passwords on Reboot'
description = 'Using Clevis and a Tang server running on an OPNsense firewall to unlock LUKS-encrypted disks automatically at boot.'
categories = ['tech']
tags = ['software', 'fedora', 'opnsense', 'security']
+++
Like many tech hobbyists, I run a fair number of servers and VMs at home, and
a lot of them hold data I would rather keep encrypted. Drives and SSDs
eventually fail (you should have backups, but that is an entry for another
day) and sometimes get stolen. If the data is encrypted, both are far less
stressful events.

The catch is that encrypted data has to be decrypted before it is useful. The
usual model, typical of Linux's [LUKS](https://gitlab.com/cryptsetup/cryptsetup)
encryption, is that someone types a passphrase at boot after every power
failure or maintenance window. LUKS can instead tie the key to the machine's
TPM, much as Windows BitLocker does, but that is less effective for VMs and
does little if the TPM is stolen along with the drive. A passphrase at boot
has real security advantages. Its serious disadvantage is that a person has to
be present to type it, every time.

## Clevis and Tang

That is the gap [Clevis](https://github.com/latchset/clevis) and
[Tang](https://github.com/latchset/tang) fill. Clevis lives on the machine
with the encrypted data and is bound to a LUKS key slot. At boot it contacts a
Tang server on the network and, through a key exchange in which the server
never learns the resulting key or keeps any per-client state, recovers the
key to unlock the disk. Red Hat calls this combination
[network-bound disk encryption](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/configuring-automated-unlocking-of-encrypted-volumes-using-policy-based-decryption_security-hardening).
The upshot is that a stolen drive stays locked unless it is also on a network
that can reach your Tang server. The cryptographic details are in the Tang
README, and I will not repeat them here.

Clevis is packaged for most Linux distributions. Tang has been ported to a
somewhat wider range of systems. The practical question is where the Tang
server should live, and the answer depends on your situation. There is a
container image, though running Tang on a VM that itself needs unlocking has
obvious drawbacks. A Raspberry Pi in a corner is another common choice,
although I am not sure how well supported that port is today.

## On an OPNsense firewall (os-tang)

If you run an [OPNsense](https://opnsense.org/) firewall, it makes a good host.
If the firewall is down, it matters less that the systems behind it can reboot
unattended, since someone will need to intervene on the firewall anyway. That
was the trade-off I found most suitable.

OPNsense is built on FreeBSD, and FreeBSD already ships ports of Tang and its
dependency [jose](https://github.com/latchset/jose), plus the
[llhttp](https://github.com/nodejs/llhttp) library it also needs. I built an
[os-tang plugin](https://github.com/hdholm/plugins/tree/tang/security/tang)
for OPNsense that manages the Tang server, exposes some configuration, and
provides very simple key management. The keys are replicated to
high-availability peer firewalls, so if your firewalls are redundant, your Tang
server is automatically redundant too.

Tang can support more elaborate arrangements, such as requiring any two of
three servers to be available. Clevis does this with its
[Shamir secret sharing pin](https://github.com/latchset/clevis#pin-shamir-secret-sharing).
os-tang does not implement it, and I do not need it, so I am unlikely to build
it without some as-yet-unseen incentive.
