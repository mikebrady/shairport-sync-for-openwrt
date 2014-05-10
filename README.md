Shairport 2.0 for OpenWRT
=========================

This is an OpenWrt package for building and installing ShairPort 2.0, which is at https://github.com/mikebrady/shairport-sync.

You need a custom version of OpenWrt which includes support for sound and for usb audio.

The approach taken here is to build the custom version in two stages: first, download to build a standard OpenWrt image for your architecture, and, second, add Shairport and all the extras it depends on.

Stage 1
-------
We assume that you have downloaded the OpenWrt build system as shown in http://wiki.openwrt.org/doc/howto/build. Follow the instructions there to select the architecture you want and do a standard build. Once OpenWrt has built successfully, you need to add Shairport and some packages it relies on.

Stage 2
-------
Let's assume you have downloaded and built OpenWrt in `~/openwrt/audio`. 

Download the Shairport 2.0 for OpenWrt package from https://github.com/mikebrady/shairport and copy the folder into `~/openwrt/audio/packages/` giving you a folder `~/openwrt/audio/packages/shairport` (or `~/openwrt/audio/packages/shairport-master` if your download using the "Download ZIP" button).

`cd` to `~/openwrt/audio/` if necessary.

Make sure all feeds are up to date by performing the following command:

`./scripts/feeds update -a`

Perform the command

`./scripts/feeds install libavahi alsa-lib alsa-utils htop`

This will install these packages into the OpenWrt build system if they are not already in place. Note that `alsa-utils` and `htop` are both useful, but they are not needed for Shairport to work.

Enter the command `make menuconfig` and make the following selections:

* select `Sound > shairport`
* select `Kernel Modules > Sound Support > kmod-sound-core` and `kmod-usb-audio`
* select `Utilities > alsa-utils` and `Administration > htop`

Having exited and confirmed your choices, do a `make`. That's it -- the image should be ready.

Running Shairport for the First Time
------------------------------------
Once you install the image on your device and restart it, (and assuming it has a soundcard), Shairport should automatically start as a result of the `/etc/init.d/airplay` initisialisation script. The parameters it uses are in `/etc/config/airplay`. If your device's IP number is within your network's subnet (see below), your device will show up in iTunes or iOS as an extra AirPlay device called "Shairport 2.0".

Please note that, by default, OpenWrt takes up location 192.168.1.1 and offers telnet access -- see http://wiki.openwrt.org/doc/howto/firstlogin for more information. (BTW, if you've built OpenWrt as instructed here, LuCI is not installed and the Login to WebUI details do not apply.)

