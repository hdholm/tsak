+++
date = '2026-09-08T00:05:01-04:00'
title = 'Decrypting Disks without Passwords on Reboot'
tags = ['software', 'tech', 'Fedora', 'OPNsense']
+++
Like many people that you might call tech hobbiests, I have a certain number of
servers, VMs, what have you, running in my home. A lot of those
things also have data on them that I would prefer to have encrypted. Hard
drives and SSDs eventually fail (you should have backups - an entry for another
day) or even get stolen. If the data is encrypted those are all far less
stressful events. 

Alas encrypted data needs to be decrypted to be useful. So often the model is
that when the system reboots after a power failure or routine maintenance a
password is manually entered to decrypt the data. This is typical of the
Linux LUKS encryption.  LUKS can, like windows bitlocker, tie the encryption
key to the system hardware TPM. But that is less effective for VMs and doesn't
really address the issue of the TPM being stolen along with the drive. So
passwords at boot have some advantages, however, a serious disadvantage is a
person needing to type in those passwords at every boot.

That's where something callled Tang and Clevis come into play. Clevis lives on
the device with the encrypted data and calls out to a Tang server when it needs
it decrypted. [Clevis](https://github.com/latchset/clevis) is available for
most Linux-based systems.  [Tang](https://github.com/latchset/tang) has been
ported to a slightly wider variety of systens. There are security details
to be sure, but for that you can dig
into the details of Tang. Here the issue is where should a tang server live.
There are a number of answers to that depending on your particular needs. There
is a tang docker - although putting it on a VM has its drawbacks. Perhaps a
Raspberry Pi off in a corner somewhere, although I'm not sure what the status
is of that port.

### On an OPNsense Firewall (with os-tang)

One possibility is to run it on an OPNsense firewall if you have one. If the
firewall is down, it's probably less important that the systems it's supporting
are able to reboot without human intervention.  After all, intervention is
probably going to be needed for the firewall. That was the solution I decided
was mostly optimal for me. OPNsense is built on top of FreeBSD.  There is a
FreeBSD port of tang and it's dependency jose. The llhttp package is also
required and available on FreeBSD. I built an
[os-tang plugin](https://github.com/hdholm/plugins/tree/tang/security/tang)
for OPNsense
which manages the tang server allowing some configuration as well as some VERY
simple key management. Part of the simple key management is that the keys are
replicated to High Availability peer firewalls so if you have that redundancy
in your firewalls the tang server is automatically also redundant.  Tang could
suport more complex key systems, e.g., needing two of three firewalls to be
available but that's not implemented in os-tang and I don't need that so I'm
unlikely to build that with some as yet unseeen incentive.
