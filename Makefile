#
# Copyright (C) 2014 OpenWrt.org  
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# updated to work with latest source from abrasive
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shairport-sync
PKG_VERSION:=2.0
PKG_RELEASE:=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/mikebrady/shairport-sync.git
PKG_SOURCE_VERSION:=HEAD
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/shairport-sync
  SECTION:=sound
  CATEGORY:=Sound
  DEPENDS:= +libpthread +libopenssl +libavahi-client +alsa-lib +libdaemon
  TITLE:=ShairPort-Sync 2.0
endef

CONFIGURE_ARGS+= \
	--with-alsa \
	--with-avahi

define Build/Configure
	(cd $(PKG_BUILD_DIR); autoreconf -i)
	$(call Build/Configure/Default, )
endef

define Package/shairport-sync/description
  ShairPort-sync is server software that implements the RAOP protocol for
  playback of music streamed from a compatible remote client.
  This is ShairPort-sync 2.0.
endef


define Package/shairport-sync/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/shairport $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/airplay.init $(1)/etc/init.d/airplay
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/airplay.config $(1)/etc/config/airplay
	$(INSTALL_DATA) ./files/asound.conf $(1)/etc/
endef


$(eval $(call BuildPackage,shairport-sync))
