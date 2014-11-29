#
# Copyright (C) 2014 OpenWrt.org  
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# updated to work with latest source from abrasive
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shairport-sync
PKG_VERSION:=HEAD
PKG_RELEASE:=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/mikebrady/shairport-sync.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_PARALLEL:=1

PKG_BUILD_DEPENDS:= +libpthread +libopenssl +alsa-lib +libdaemon

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS+= \
	--with-alsa \
	--with-tinysvcmdns \
	--with-ssl=openssl

define Build/Configure
	(cd $(PKG_BUILD_DIR); autoreconf -i -f)
	$(call Build/Configure/Default, )
endef

define Package/shairport-sync/Default
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=iPhone/iTunes/Quicktime Player compatible Audio Player
endef

define Package/shairport-sync
  $(Package/shairport-sync/Default)
   DEPENDS:= +libpthread +libopenssl +alsa-lib +libdaemon +libpopt
endef

define Package/shairport-sync/description
  Shairport Sync is server software that implements the Apple-originated RAOP protocol for
  playback of audio from a compatible remote client such as the iPhone, iTunes, Apple TV, Quicktime Player or forked-daapd.
  Shairport Sync implements audio synchronisation, supporting multi-room use.
  Shairport Sync supports audio only.
endef

define Package/shairport-sync/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/shairport-sync $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/init.d/shairport-sync $(1)/etc/init.d/
	$(INSTALL_DATA) ./files/config/shairport-sync $(1)/etc/config/
	$(INSTALL_DATA) ./files/asound.conf $(1)/etc/
endef

$(eval $(call BuildPackage,shairport-sync))
