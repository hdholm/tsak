+++
date = '2026-09-08T00:05:01-04:00'
title = 'Decrypting Disks without Passwords on Reboot'
description = 'Using Clevis and a Tang server running on an OPNsense firewall to unlock LUKS-encrypted disks automatically at boot.'
categories = ['tech']
tags = ['software', 'fedora', 'opnsense', 'security']
+++
Like many tech hobbyists, I run a number of servers and VMs at home,
and a lot of them hold personal data such as banking information and
authentication that I would rather not become public. Hard drives and
SSDs eventually fail (you should have backups, but that is an article
for another day) and sometimes get stolen. If the data is encrypted,
losing control of the drives is far less problematic.

Encrypted data, however, must be decrypted to be used. The usual
model, of which Linux's
[LUKS](https://gitlab.com/cryptsetup/cryptsetup) encryption is
typical, is that someone types a passphrase at boot after every power
failure or maintenance window. Not so bad for a laptop, but really
painful for a small fleet of servers and VMs. LUKS can instead tie the
key to the machine's TPM, much as Windows BitLocker does, but that is
not particularly effective for VMs and does little if the TPM is
stolen along with the drive. A passphrase at boot has real security
advantages. Its serious disadvantage is that a person has to be
present to type it, every time.

## Clevis and Tang

That is the gap [Clevis](https://github.com/latchset/clevis) and
[Tang](https://github.com/latchset/tang) fill. Clevis lives on the
machine with the encrypted data and is bound to a LUKS key slot. At
boot it contacts one or more Tang servers on the network and, through
a key exchange in which the server never learns the resulting key or
keeps any per-client state, recovers the key to unlock the disk. Red
Hat calls this combination [network-bound disk
encryption](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/configuring-automated-unlocking-of-encrypted-volumes-using-policy-based-decryption_security-hardening).
The upshot is that a stolen drive stays encrypted unless it is also on
a network that can reach your Tang server. The cryptographic details
are in the [Tang
README](https://github.com/latchset/tang/blob/master/README.md), so I
won't go into them here.

Clevis is packaged for most Linux distributions. Tang has been ported
to a somewhat wider range of systems. It would be nice if someone
would port clevis to more platforms, but that person isn't me. The
practical question is where the Tang server should live. A docker
container image is available, although running Tang on a VM that
itself needs unlocking has obvious drawbacks. A Raspberry Pi in a
corner is [another common
choice](https://medium.com/@damianwcybersec/building-a-three-node-tang-key-server-mesh-using-armbian-powered-sbcs-84bb4e8b6a15),
although I am not sure how well supported that port is today.

## On an OPNsense firewall (os-tang)

If you run an [OPNsense](https://opnsense.org/) firewall, it can make a good tang host.
If the firewall is down, it matters less that the systems behind it can reboot
unattended, as someone will need to intervene on the firewall anyway. That
was the trade-off I found most reasonable.

OPNsense is built on FreeBSD, and FreeBSD already ships ports of Tang
and its dependency [jose](https://github.com/latchset/jose), plus the
[llhttp](https://github.com/nodejs/llhttp) library it also needs. I
built an [os-tang
plugin](https://github.com/hdholm/plugins/tree/tang/security/tang) for
OPNsense that manages the Tang server, exposes some configuration, and
provides very simple key management. The keys are replicated to
high-availability peer firewalls, so if your firewalls are redundant,
your Tang server is automatically redundant too. This is not perhaps
the "best" way to run mulitple tang servers but it is simple and
effective.

Tang can support more elaborate arrangements, such as requiring any
two of three servers to be available. Clevis does this with its
[Shamir secret sharing
pin](https://github.com/latchset/clevis#pin-shamir-secret-sharing).
os-tang does not do anything to facilitate such arrangements. Since I
don't need it, I am also unlikely to implement anything more
sophisticated without some as-yet-unseen incentive.
