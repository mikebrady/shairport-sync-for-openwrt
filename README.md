Shairport 2.0 for OpenWRT
=========================

This is an OpenWrt package for building and installing ShairPort 2.0, which is at https://github.com/mikebrady/shairport-sync.

You need a custom version of OpenWrt which includes support for sound and for usb audio.

The approach taken here is to build the custom version in two stages: first, download to build a standard OpenWrt image for your architecture, and, second, add Shairport and all the extras it depends on.

Stage 1
-------
We assume that you have downloaded the OpenWrt build system as shown in http://wiki.openwrt.org/doc/howto/build. Follow the instructions there to select the architecture you want and do a standard build. Once OpenWrt has built successfully, you need to add `shairport` and some packages it relies on.

Stage 2
-------
Let's assume you have downloaded and built OpenWrt in `~/openwrt/audio`. 

Download the ShairPort OpenWrt package from https://github.com/mikebrady/shairport and copy the folder into `~/openwrt/audio/packages/` giving you a folder `~/openwrt/audio/packages/`.

`cd` to `~/openwrt/audio/` if necessary.

Make sure all feeds are up to date by performing the following command:

`./scripts/feeds update -a`

Perform the command `./scripts/feeds install libavahi alsa-lib alsa-utils htop`. This will install these packages into the OpenWrt build system if they are not already in place. Note that `alsa-utils` and `htop` are both useful, but they are not needed for shairport to work.

Enter the command `make menuconfig` and make the following selections:

* select `Sound > shairport`;
* select `Network Modules > Sound Support > kmod-sound-core` and `kmod-usb-audio`;
* select `Utilities > alsa-utils` and `Administration > htop`; finally
* select `Network > IP Addresses and Names > avahi-autoipd`


Having confirmed your choices and exited do a `make`. That's it -- the image should be ready.


