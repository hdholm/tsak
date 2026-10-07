+++
date = '2026-09-06T01:50:01-04:00'
title = 'Local Fedora Mirror'                                      
description = 'Building a lightweight local mirror of Fedora repositories with dnf reposync, createrepo_c and nginx.'
categories = ['tech']
tags = ['software','Fedora']
+++
If you maintain more than a few Fedora systems, having each machine download
the same updates through your internet connection can waste time and bandwidth.
A local repository mirror lets you download those packages once to your network
and reuse them. It can also serve any locally produced packages to your systems
although that is not implemented in the script below.

## Planning

This script is a deliberately simple setup, not the Fedora MirrorManager 
[Mirror Management System](https://fedoraproject.org/wiki/Infrastructure/Mirroring)
which may be more appropriate depending on what you are doing. This script can
be hosted on a physical or virtual server. Mirroring the actively updated
repositories can take upwards of 550 GiB as configured below, so it is probably
worth giving it its own drive. Whether that is part of the root filesystem or a
dedicated mount, the script and steps below assume that storage is at
`/opt/mirror`.

After setup, the routine operations can run from a non-root account. I call it
`muser` ("mirror user") below, but any account works.

Specifically:

- It mirrors x86_64 and combines it with the i686 and noarch packages. To
  mirror another architecture, change `x86_64` to that architecture and drop
  `i686`. That may duplicate every noarch RPM in each architecture's tree.
- It does not do the full hard-linking that the officially supported mirror
  tools do. In exchange, it needs no coordination with mirror hosts and uses
  [dnf reposync](https://dnf5.readthedocs.io/en/latest/dnf5_plugins/reposync.8.html)
  and dnf's built-in mirror selection to fetch from an appropriate upstream
  mirror. The reposync documentation describes architecture selection, destination
  paths, deletion of packages removed upstream, and metadata downloading.
- It assumes the mirror server itself runs the most recent desired Fedora
  release. It does *not* currently mirror Rawhide or testing.
- It keeps the release running on the server (assumed to be the current release
  of Fedora) and the two previous releases.  Since Fedora only suppors the
  current release and the previous release with updates this should be
  sufficient for an update server.
- With `--download-metadata`, reposync can retain upstream repository
  metadata instead of rebuilding it with `createrepo_c`. Do not combine that
  approach with `--newest-only` without accounting for metadata that still
  refers to omitted older packages. Additionally we don't use that in this
  script because we combine the x86_64, i686, and noarch repos.

You can serve the mirror securely by configuring nginx for TLS with a
certificate from [Let's Encrypt](https://letsencrypt.org/), issued by any
[ACME client](https://letsencrypt.org/docs/client-options/).

## Setup

```sh
sudo dnf install dnf5-plugins nginx createrepo_c

# modify /etc/nginx/nginx.conf to use /opt/mirror as its directory
# by changing the root directive to /opt/mirror
sudo vi /etc/nginx/nginx.conf

sudo mkdir /opt/mirror/x86_64/

# assuming you have SELinux enabled
sudo semanage fcontext -a -t httpd_sys_content_t "/opt/mirror(/.*)?"
sudo restorecon -Rv /opt/mirror
```

The `semanage fcontext` rule labels the mirror so SELinux lets nginx read it
(see Red Hat's guide to
[Setting up nginx](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/deploying_web_servers_and_reverse_proxies/setting-up-and-configuring-nginx) which talks about configuring the contexts),
and `restorecon` applies the label to files already in place. The mirror
directory must exist before the script runs.

## The mirror script

Save this as `mirror.sh`. Replace `dl.example.com` with the hostname your
clients will use to reach the mirror.

```sh
#! /bin/bash

# release_number is to to VERSION_ID from /etc/os_release; uncomment this to set
# release_number manually to not have it float with the version of the mirror server
#release_number=44
mirror_root=/opt/mirror

# Kernel-managed lock: released when the process exits, including on errors.
exec 9>"$mirror_root/.sync.lock"
flock -n 9 || {
    echo 'Another mirror synchronization is running.' >&2
    exit 1
}
# Use the Fedora release of the mirror host itself (release_number in /etc/os-release).
# To move the mirror to a new release, just upgrade the mirror host.

source /etc/os-release
if [[ ! $release_number =~ ^[0-9]+$ ]]; then
    if [[ $VERSION_ID =~ ^[0-9]+$ ]]; then
        release_number=${VERSION_ID}
    else
        echo "[ERROR] Cannot determine a numeric Fedora release."
        exit
    fi
fi
if [[ ! -d ${mirror_root}/x86_64/ ]]; then
    # make sure the device is mounted if we have it on a separate drive
    /bin/mount ${mirror_root} > /dev/null 2>&1
    if [[ ! -d ${mirror_root}/x86_64/ ]]; then
        echo "[ERROR] Mirror directories don't exist - maybe failed mount."
        exit
    fi
fi

# Needed ONCE after each release. If the -3 version exists, a new version must
# have been installed. Remove the -3 version, create the directory for the new
# version, and populate its primary fedora repo.
if [ -d ${mirror_root}/x86_64/"$((release_number - 3))" ]; then
    echo "[INFO] Removing ${mirror_root}/x86_64/$((release_number - 3))"
    rm -rf ${mirror_root}/x86_64/"$((release_number - 3))"
fi

# Mirror updates for the current and two previous releases. The "fedora" repo
# itself should not change after its initial download so if it exists we don't
# need to refresh; if it doesn't we need to create that version directory.
for working_release in "$release_number" "$((release_number - 1))" "$((release_number - 2))"
do
    if [ ! -d ${mirror_root}/x86_64/"$working_release" ]; then
        echo "[INFO] Creating and populating ${mirror_root}/x86_64/$working_release"
        mkdir ${mirror_root}/x86_64/"$working_release"
        cd ${mirror_root}/x86_64/"$working_release"/
        dnf5 --releasever="$working_release" --refresh reposync --download-metadata \
            --remote-time -a x86_64 -a noarch -a i686 --repoid=fedora
        rm ${mirror_root}/x86_64/"$working_release"/fedora/metalink.xml
    else
        cd ${mirror_root}/x86_64/"$working_release"/
    fi
    dnf5 --refresh --releasever="$working_release" reposync -n --delete \
        --remote-time -a x86_64 -a noarch -a i686 \
        --repoid=updates,google-chrome,fedora-cisco-openh264 2>&1 \
        | grep -Ev "Already downloaded|100% \|   0.0   B/s \|   0.0   B \|  00m00s"
    echo "[INFO] Updating Updates $working_release metadata"
    createrepo_c --update -q \
        -u https://dl.hdholm.net/x86_64/"$working_release"/updates/ \
        updates/
    echo "[INFO] Updating google-chrome $working_release metadata"
    createrepo_c --update -q \
        -u https://dl.hdholm.net/x86_64/"$working_release"/google-chrome/ \
        google-chrome/
    echo "[INFO] Updating fedora-cisco-openh264 $working_release metadata"
    createrepo_c --update -q \
        -u https://dl.hdholm.net/x86_64/"$working_release"/fedora-cisco-openh264/ \
        fedora-cisco-openh264/
done
```

Notes on the script:

- The `-u` option to `createrepo_c` records in the metadata the URL your
  clients will use. See the
  [createrepo_c documentation](https://github.com/rpm-software-management/createrepo_c)
  for the other options.
- The `google-chrome` and `fedora-cisco-openh264` repositories must already be
  configured on the mirror host. Drop them from the script if you do not use
  them. Fedora documents the Cisco repository in its
  [OpenH264 guide](https://docs.fedoraproject.org/en-US/quick-docs/openh264/).

## Scheduling

Finally update the file permissions and make a crontab for the user that will
be running the mirror.
```sh
sudo chown -R muser:muser /opt/mirror
sudo EDITOR=vi crontab -e -u muser
```

```sh
SHELL = /bin/bash

47 */3 * * * /home/muser/mirror.sh
```

That runs the script at 47 minutes past the hour, every three hours. The odd
minute avoids hitting upstream mirrors at the top of the hour.  Depending on
your needs, running it once a day or less may be appropriate.
