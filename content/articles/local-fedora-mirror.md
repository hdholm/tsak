+++
date = '2026-09-06T01:50:01-04:00'
title = 'Local Fedora Mirror'
tags = ['software','Fedora','tech']
+++
If you havve a collection of systems running Fedora and don't want waste the
time having each system pull software updates across your Internet connection
you can build a local mirror, which can also provide any locally produced
software to your systems.

You can set up a physical or virtual local mirror server.  Note that mirroring
the actively updated repositories can take upwards of 550 GiB. So it may be
useful to put this on it's own drive.  Whether it's part of the root file
system or mounted from a dedicated drive the following assumes that the storage
will be on /opt/mirror.

After setup, the routine operations below can be run from a non-root account.
Here that account is shown as muser (Mirror User) but can be any account. This
script mirrors the x86_64 architecture and combines it with the i686 adn noarch
architectures. If you want to mirror another architecture changing the x86_64
to your architecture and removing the i686 may be what you want, but that may
make duplicates of all noarch RPMs in each architecture's directory tree.  This
mirror setup does not deal with the full hard-linking that the fully supported
mirror software does.  On the other hand, it does not require coordination with
any mirror hosts and uses dnf's built in mirror system to pull it's copy from
an appropriate mirror.

The mirror script assumes that the mirror server itself is maintained at the
current Fedora release.  It does NOT currently mirror rawhide or testing.

You can easily set this up as a secure service if you want by using the nginx
secure configuration and using acme and Let's Encrypt certificates for the
server.

```sh
sudo dnf install nginx createrepo_c
sudo vi /etc/nginx/nginx.conf
# modify /etc/nginx/nginx.conf to use /opt/mirror as it's directory
# by changing the root directive to /opt/mirror
sudo semanage fcontext -a -t httpd_sys_content_t "/opt/mirror(/.*)?"
sudo mkdir /opt/mirror/x86_64/
```

Create the following shell script as mirror.sh
```sh
#! /bin/bash

# pull the version of Fedora on the mirror host from VERSION_ID in /etc/os-release
# So to update the mirror, just upgrade the mirror host and the mirror automatically updates to the latest release
source /etc/os-release

if [[ $VERSION_ID =~ ^[0-9]+$ ]]; then
    /bin/mount /opt/mirror > /dev/null 2>&1
else
    echo "[ERROR] Version $VERSION_ID is not an integer" 
    exit
fi
if [[ ! -d /opt/mirror/x86_64/ ]]; then
    echo "[ERROR] Mirror directories don't exist - maybe failed mount." 
    exit
fi
if [ -e /opt/mirror/.in_progress ]; then
    echo "[WARNING] Script alreday in progress, aborting..."
    exit
else
    echo $$ > /opt/mirror/.in_progress
fi
# Need this ONCE after each version is officially released.  If the -3 version exists then a new version must have been installed.
# So remove the -3 version and create the directory for the new version and populate the primary fedora repo for it.
if [ -d /opt/mirror/x86_64/"$((VERSION_ID - 3))" ]; then
    echo "[INFO] Removing /opt/mirror/x86_64/$((VERSION_ID - 3))"
    rm -rf /opt/mirror/x86_64/"$((VERSION_ID - 3))"
fi
if [ ! -d /opt/mirror/x86_64/"$VERSION_ID" ]; then
   echo "[INFO] Creating and populating /opt/mirror/x86_64/$VERSION_ID"
   mkdir /opt/mirror/x86_64/"$VERSION_ID"
   cd /opt/mirror/x86_64/"$VERSION_ID"/
   dnf --releasever="$VERSION_ID" --refresh reposync --download-metadata --remote-time -a x86_64 -a noarch -a i686 --repoid=fedora
   rm /opt/mirror/x86_64/"$VERSION_ID"/fedora/metalink.xml
fi

# Mirror the updates for the current and two previous versions of Fedora the "Fedora" repo itself shouldn't need updates after initial population
for MIRROR_VER in "$VERSION_ID" "$((VERSION_ID - 1))" "$((VERSION_ID - 2))"
do
    cd /opt/mirror/x86_64/"$MIRROR_VER"/
    dnf --refresh --releasever="$MIRROR_VER" reposync -n --delete --remote-time -a x86_64 -a noarch -a i686 --repoid=updates,google-chrome,fedora-cisco-openh264 2>&1 \
        | grep -Ev "Already downloaded|100% \|   0.0   B/s \|   0.0   B \|  00m00s"
    echo "[INFO] Updating Updates $MIRROR_VER metadata"
    createrepo_c --update -q -u https://dl.hdholm.net/x86_64/"$MIRROR_VER"/updates/ updates/
    echo "[INFO] Updating google-chrome $MIRROR_VER metadata"
    createrepo_c --update -q -u https://dl.hdholm.net/x86_64/"$MIRROR_VER"/google-chrome/ google-chrome/
    echo "[INFO] Updating fedora-cisco-openh264 $MIRROR_VER metadata"
    createrepo_c --update -q -u https://dl.hdholm.net/x86_64/"$MIRROR_VER"/fedora-cisco-openh264/ fedora-cisco-openh264/
done
rm /opt/mirror/.in_progress
```

Finally update the file permissions and make a crontab for the user that will
be running the mirror.
```sh
sudo chown -R muser:muser /opt/mirror
sudo EDITOR=vi crontab -e -u muser
```

```sh
SHELL = /bin/bash

47 */3 * * * /home/howard/mirror.sh
```
