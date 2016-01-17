Shairport Sync for OpenWrt "Barrier Breaker" and "Chaos Calmer"
======================
The purpose of this package is to allow you to install Shairport Sync into an OpenWrt "Barrier Breaker" system or to update the version of Shairport Sync in "Chaos Calmer". There is already a Shairport Sync package in OpenWrt's package feed from "Designated Driver" onwards, which you should use in preference to this. 

Shairport Sync is an AirPlay audio player -- it plays audio streamed from iTunes, iOS devices and third-party AirPlay sources such as ForkedDaapd and others.
Audio played by a Shairport Sync-powered device stays synchronised with the source and hence with similar devices playing the same source. In this way, synchronised multi-room audio is possible without difficulty. (Hence the name Shairport Sync, BTW.)

Shairport Sync does not support AirPlay video or photo streaming.

The approach taken here is to build a custom version of OpenWrt in two stages: first, download and build OpenWrt, and, second, add Shairport Sync and all the extras it depends on.

Stage 1
-------
We assume that you have downloaded the OpenWrt build system as shown at http://wiki.openwrt.org/doc/howto/buildroot.exigence (or http://wiki.openwrt.org/doc/howto/build). Follow the instructions there to select the architecture you want and do a standard build of "Barrier Breaker" or "Chaos Calmer". Once it has built successfully, you need to add Shairport Sync and some packages it relies on.

Stage 2
-------
Let's say you have downloaded and built OpenWrt in `~/openwrt/audio`.

If you are building Shairport Sync for the first time, you may need to add a package to your host system to enable it to build all the extra packages required:
* Install a Perl XML parser module to your host build system with the following command:
* `$sudo apt-get install libxml-parser-perl`

(**Note**: If you are updating to the latest Shairport Sync from the old version in the Chaos Calmer package feed, use `$make menuconfig` to deselect the `shairport-sync` package and then use `$./scripts/feeds uninstall shairport-sync` to remove the package from the list of packages available.)

Now you can proceed with building Shairport Sync and the other packages it requires:

* Move to `~/openwrt/audio/`: `$cd ~/openwrt/audio/`

* Make sure all feeds are up to date by performing the following command:
`$./scripts/feeds update -a`

* Ensure `libsoxr` is available: Check to see if the `libsoxr` package is available. Do this be searching for it: `$./scripts/feeds search libsoxr`. If it's there, install it: `$./scripts/feeds install libsoxr`. If `libsoxr` is not in the packages feed, you will have to download it – see below.

* * Move to the packages directory: `$cd ~/openwrt/audio/package/`.

* If `libsoxr` is not in the packages feed (see previous section), download the `Libsoxr for OpenWrt` package: `$git clone https://github.com/mikebrady/libsoxr-for-openwrt.git`

* Download the `Shairport Sync for OpenWrt` package: `$git clone https://github.com/mikebrady/shairport-sync-for-openwrt.git`.
* Enter the directory and checkout the `barrier-breaker` branch:
```
$cd shairport-sync-for-openwrt
$git checkout barrier-breaker
```
* Next, move back to `~/openwrt/audio/`: `$cd ~/openwrt/audio/`

* Perform the command
`$./scripts/feeds install libavahi alsa-lib libdaemon libpopt alsa-utils htop `
This will install these packages into the OpenWrt build system if they are not already in place. All these packages are necessary for building Shairport Sync, but they will only be included in the final OpenWrt image if they are needed at runtime. For example, `libavahi` is needed for compilation, but avahi will not be included in the OpenWrt image if you choose the `shairport-sync-mini` package.
Note that `alsa-utils` and `htop` are both very useful, but they are not actually needed for Shairport Sync to work.

* Enter the command `make menuconfig` and make the following selections:
 * select exactly one of `Sound > shairport-sync-mini` or `shairport-sync-polarssl` or `shairport-sync-openssl`,
 * select `Kernel Modules > Sound Support > kmod-sound-core` and `kmod-usb-audio`,
 * optionally, but recommended, select `Utilities > alsa-utils` and `Administration > htop`.

* Having exited and confirmed your choices, do a `make`. That's it -- the image should be ready.

Running Shairport Sync for the First Time
------------------------------------
Once you install the image on your device and restart it, (and assuming it has a soundcard), Shairport Sync should automatically start as a result of the `/etc/init.d/shairport-sync` initialisation script. The parameters it uses are in `/etc/config/shairport-sync`. If your device's IP number is within your network's subnet (see below), your device will show up in iTunes or iOS as an extra AirPlay device called "Shairport Sync on ...your computer's hostname...".

The settings file is `/etc/config/shairport-sync`. Whichever configuration stanza you use, remember to enable it by deleting the line in the stanza that reads:
```
        option disabled '1' # delete this line to use your own config file
```
Please note that, by default, OpenWrt takes up location `192.168.1.1` and offers `telnet` access -- see http://wiki.openwrt.org/doc/howto/firstlogin for more information. (BTW, if you've built OpenWrt as instructed here, `LuCI` is not installed and the Login to WebUI details do not apply.)

Replacing Shairport Sync in an existing installation
------------------------------------
* Stop the Shairport Sync service using`/etc/init.d/shairport-sync stop`.
* Take note of any settings you need, as the installation will delete all settings. This version of Shairport Sync uses the `procd` system to start up and it reads its settings from a new version of the `/etc/config/shairport-sync` file.
* Delete the file `/etc/init.d/shairport-sync`.
* If necessary, install the `libsoxr` library by copying over the package and using `opkg`.
* Install the relevant `shairport-sync` library the same way.
* Enter your settings in the settings file. This is at `/etc/config/shairport-sync`. Whichever configuration stanza you use, remember to enable it by deleting the line in the stanza that reads:
```
        option disabled '1' # delete this line to use your own config file
```
* Start the Shairport Sync service using`/etc/init.d/shairport-sync start`.
