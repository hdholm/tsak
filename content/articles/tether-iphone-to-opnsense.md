+++
date = '2026-09-06T14:30:06-04:00'
title = 'Tether iPhone to OPNsense'
tags = ['software', 'OPNsense', 'tech']
+++
Last updated for OPNsense 26.7.3_11

If you have an OPNsense firewall and you also happen to have a spare iPhone
around with a cell plan that enables tethering, you can use the iPhone to
connect your router to the cell network as it's WAN.  This can be particularly
useful in longer network outages due to, for example, a hurricane taking down
Xfinity in your area for more than a week. Just an example. Anyway there are
some hurdles. Of course, it's best to configure this BEFORE you need it.  Once
there's a network outage it's tricky to download the things you need to set
this up as your backup plan.

The first thing to note is [this bug](https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=289455).
As of OPNsense 26.7.3_11 it is not yet fixed in OPNsense. So the workaround to
install anything you need from the FreeBSD repos below is to lock the package
manager so that it's not upgraded as a side effect of using the FreeBSD repos
and enable the FreeBSD repo and then undo all those changes.
```sh
kldload ipheth
pkg lock pkg # to prevent upgreading pkg while using the FreeBSD repo
vi /usr/local/etc/pkg/repos/FreeBSD.conf
# Change FreeBSD: { enabled: no }
# to     FreeBSD: ( enabled: yes}

pkg install usbmuxd
pkg unlock pkg
vi /usr/local/etc/pkg/repos/FreeBSD.conf
# Change FreeBSD: { enabled: no }                                               
# to     FreeBSD: ( enabled: yes}                                               
``` 
Once that bug is fixed in OPNsense you can do the much simpler
```sh
kldload ipheth
pkg install -r FreeBSD usbmuxd
```
It's possible at this point that things are working, but if not you may need
to help things along.
```sh
dmesg | grep apple # to get the ugen number (where 0.2 is the example below)
usbconfig -d 0.2 set_config 3
usbmuxd --enable-exit --user root
```

Once you have it working you will probably want to make it persistent on
reboots.  In `/boot/loader.conf.local` add
```sh
if_ipheth_load="YES" 
```
If usbmuxd needed configuration, you may need to create
`/usr/local/etc/rc.syshook.d/early/tether.sh` and make it executable
`chmod +x /usr/local/etc/rc.syshook.d/early/tether.sh` containing the
following to make it persistent.  Ideally this is not necessary as
`/usr/local/etc/devd/usbmuxd.conf` should handle starting and configuring.
```sh
usbconfig -d 0.2 set_config 3 # where 0.2 is the number found earlier
usbmuxd --enable-exit --user root
```

See Also
========
[Related discussion for pfSense](https://forum.netgate.com/topic/106435/iphone-tether/2)
