Shairport Sync for OpenWRT
=========================

This is an OpenWrt package for building and installing ShairPort Sync, which is at https://github.com/mikebrady/shairport-sync. [Working on OpenWrt trunk on May 22, 2014.]

If you want to support USB-based audio devices, you need a custom version of OpenWrt which includes support for usb audio.

Please note that the sound card you use must be capable of working with 44,100 audio frames per second interleaved PCM stereo.

The approach taken here is to build the custom version in two stages: first, download and build a standard OpenWrt image for your architecture, and, second, add Shairport and all the extras it depends on.

Stage 1
-------
We assume that you have downloaded the OpenWrt build system as shown at http://wiki.openwrt.org/doc/howto/build. Follow the instructions there to select the architecture you want and do a standard build. Once OpenWrt has built successfully, you need to add Shairport Sync and some packages it relies on.

Stage 2
-------
Let's say you have downloaded and built OpenWrt in `~/openwrt/audio`.

Before building Shairport Sync, you need to add a package to your host system, to enable it to build all the extra packages required:
* Install a Perl XML parser module to your host build system with the follwing command:
* `$sudo apt-get install libxml-parser-perl`

Now you can proceed with building Shairport Sync and the other packages it requires:
* Move to the packages directory: `$cd ~/openwrt/audio/package/`.

* Download the `Shairport Sync for OpenWrt` package:
* `$git clone https://github.com/mikebrady/shairport.git`

* Next, move back to `~/openwrt/audio/`: `$cd ~/openwrt/audio/`

* Make sure all feeds are up to date by performing the following command:
`$./scripts/feeds update -a`

* Perform the command
`$./scripts/feeds install libavahi alsa-lib libdaemon alsa-utils htop `
This will install these packages into the OpenWrt build system if they are not already in place. Note that alsa-utils and htop are both useful, but they are not needed for Shairport to work.

* Enter the command `make menuconfig` and make the following selections:
* select `Sound > shairport`
* select `Kernel Modules > Sound Support > kmod-sound-core` and `kmod-usb-audio`
* select `Utilities > alsa-utils` and `Administration > htop`

* Having exited and confirmed your choices, do a `make`. That's it -- the image should be ready.

Running Shairport Sync for the First Time
------------------------------------
Once you install the image on your device and restart it, (and assuming it has a soundcard), Shairport Sync should automatically start as a result of the `/etc/init.d/airplay` initialisation script. The parameters it uses are in `/etc/config/airplay`. If your device's IP number is within your network's subnet (see below), your device will show up in iTunes or iOS as an extra AirPlay device called "(Hostname) Shairport Sync".

Please note that, by default, OpenWrt takes up location 192.168.1.1 and offers telnet access -- see http://wiki.openwrt.org/doc/howto/firstlogin for more information. (BTW, if you've built OpenWrt as instructed here, LuCI is not installed and the Login to WebUI details do not apply.)

