+++
date = '2026-09-06T14:30:06-04:00'
title = 'Tether iPhone to OPNsense'
description = 'Using a spare tethering iPhone as a backup WAN for an OPNsense firewall, including the usbmuxd and ipheth setup.'
categories = ['tech']
tags = ['software', 'opnsense', 'networking']
+++
*Last updated for OPNsense 26.7.3_11.*

If you have an [OPNsense](https://opnsense.org/) firewall and a spare iPhone on
a cell plan that allows tethering, you can use the phone as the firewall's WAN
connection to the cell network. This is handy in a long outage, for example a
hurricane taking down your cable provider for more than a week. (Just an
example.)

There are some hurdles, and it is best to configure all of this *before* you
need it. During an outage it is hard to download the things you need.

## Install usbmuxd

The iPhone is handled by FreeBSD's
[`ipheth`](https://man.freebsd.org/cgi/man.cgi?query=ipheth) driver together
with [`usbmuxd`](https://github.com/libimobiledevice/usbmuxd), and `usbmuxd`
is only in the FreeBSD package repository, not OPNsense's.

The first thing to know is [this bug](https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=289455).
As of OPNsense 26.7.3_11 it is not fixed in OPNsense. The workaround is to lock
the package manager so it is not upgraded as a side effect of using the
FreeBSD repository, enable that repository, install, and then undo the changes:

```sh
kldload ipheth
pkg lock pkg                 # prevent upgrading pkg while using the FreeBSD repo
vi /usr/local/etc/pkg/repos/FreeBSD.conf
# Change    FreeBSD: { enabled: no }
# to        FreeBSD: { enabled: yes }

pkg install usbmuxd
pkg unlock pkg
vi /usr/local/etc/pkg/repos/FreeBSD.conf
# Change    FreeBSD: { enabled: yes }
# back to   FreeBSD: { enabled: no }
```

Once the bug is fixed in OPNsense, this simplifies to:

```sh
kldload ipheth
pkg install -r FreeBSD usbmuxd
```

## Getting the phone recognized

Everything may work at this point. If not, you may need to help it along. Find
the phone's USB device number, then set its configuration (see
[`usbconfig(8)`](https://man.freebsd.org/cgi/man.cgi?query=usbconfig)) and start
`usbmuxd`:

```sh
dmesg | grep -i apple        # find the ugen number; 0.2 is used as the example below
usbconfig -d 0.2 set_config 3
usbmuxd --enable-exit --user root
```

## Making it persistent

To load the driver at every boot, add this to `/boot/loader.conf.local`:

```sh
if_ipheth_load="YES"
```

If `usbmuxd` needed manual configuration, you may also need a boot-time script.
Create `/usr/local/etc/rc.syshook.d/early/tether.sh`, make it executable with
`chmod +x`, and put this in it, using the device number you found earlier:

```sh
usbconfig -d 0.2 set_config 3
usbmuxd --enable-exit --user root
```

Ideally this is unnecessary, since `/usr/local/etc/devd/usbmuxd.conf`, installed
with the package, should start and configure `usbmuxd` when the phone is
attached. Note that the device number can change if you plug the phone into a
different USB port.

## See also

- [Related discussion for pfSense](https://forum.netgate.com/topic/106435/iphone-tether/2)
