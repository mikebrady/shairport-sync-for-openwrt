Shairport 2.0 for OpenWRT
=========================

This is an OpenWrt package for building and installing ShairPort 2.0.

Instructions
------------
We assume that you have downloaded the OpenWrt build system as shown in http://wiki.openwrt.org/doc/howto/build. Let's assume you have downloaded the repository to `~/openwrt/audio`. Follow the instructions there to select the architecture you want and do a standard build.

Once OpenWrt has built successfully, you need to add `shairport` and some packages it relies on.




Download the ShairPort OpenWrt package from https://github.com/mikebrady/shairport. Copy the folder to `~/openwrt/audio/packages`.

`cd` to `~/openwrt/audio/` if necessary.

Perform the command `./scripts/feeds install libavahi alsa-lib alsa-utils htop`. Note that while alsa-utils and htop are both useful, they are not needed for shairport to work.

Enter the command `make menuconfig` and make the following selections:

select `Sound > shairport`;
select `Network Modules > Sound Support > kmod-sound-core` and `kmod-usb-audio`;
select `Utilities > alsa-utils` and `Administration > htop`; finally
select `Network > IP Addresses and Names > avahi-autoipd`


Having confirmed your choices and exited do a `make`. That's it -- the image should be ready.


