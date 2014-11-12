Shairport Sync for OpenWrt
======================

This is an OpenWrt package for building and installing ShairPort Sync, which is at https://github.com/mikebrady/shairport-sync.
Shairport Sync allows you to play audio from iTunes or from an iOS device. The audio stays synchronised with other audio devices playing from the same source. Please note that the sound card you use must be capable of working with 44,100 audio frames per second interleaved PCM stereo.

The approach taken here is to build a custom version of OpenWrt in two stages: first, download and build standard trunk OpenWrt, and, second, add Shairport Sync and all the extras it depends on.

Stage 1
-------
We assume that you have downloaded the OpenWrt build system as shown at http://wiki.openwrt.org/doc/howto/buildroot.exigence (or http://wiki.openwrt.org/doc/howto/build). Follow the instructions there to select the architecture you want and do a standard build of "trunk" OpenWrt. Once OpenWrt has built successfully, you need to add Shairport Sync and some packages it relies on.

Stage 2
-------
Let's say you have downloaded and built OpenWrt in `~/openwrt/audio`.

Before building Shairport Sync, you may need to add a package to your host system to enable it to build all the extra packages required:
* Install a Perl XML parser module to your host build system with the following command:
* `$sudo apt-get install libxml-parser-perl`

Now you can proceed with building Shairport Sync and the other packages it requires:

* Move to `~/openwrt/audio/`: `$cd ~/openwrt/audio/`

* Make sure all feeds are up to date by performing the following command:
`$./scripts/feeds update -a`

* Move to the packages directory: `$cd ~/openwrt/audio/package/`.

* Download the `Shairport Sync for OpenWrt` package:
* `$git clone https://github.com/mikebrady/shairport-sync-for-openwrt.git`

* Next, move back to `~/openwrt/audio/`: `$cd ~/openwrt/audio/`

* Perform the command
`$./scripts/feeds install libavahi alsa-lib libdaemon libpopt libsoxr alsa-utils htop `
This will install these packages into the OpenWrt build system if they are not already in place. Note that `alsa-utils` and `htop` are both very useful, but they are not actually needed for Shairport Sync to work.

* Enter the command `make menuconfig` and make the following selections:
* select `Sound > shairport-sync`
* select `Kernel Modules > Sound Support > kmod-sound-core` and `kmod-usb-audio`
* select `Utilities > alsa-utils` and `Administration > htop`

* Having exited and confirmed your choices, do a `make`. That's it -- the image should be ready.

Running Shairport Sync for the First Time
------------------------------------
Once you install the image on your device and restart it, (and assuming it has a soundcard), Shairport Sync should automatically start as a result of the `/etc/init.d/shairport-sync` initialisation script. The parameters it uses are in `/etc/config/shairport-sync`. If your device's IP number is within your network's subnet (see below), your device will show up in iTunes or iOS as an extra AirPlay device called "Shairport Sync on ...your computer's hostname...".

Please note that, by default, OpenWrt takes up location `192.168.1.1` and offers `telnet` access -- see http://wiki.openwrt.org/doc/howto/firstlogin for more information. (BTW, if you've built OpenWrt as instructed here, `LuCI` is not installed and the Login to WebUI details do not apply.)

