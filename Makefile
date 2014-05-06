#
# Copyright (C) 2014 OpenWrt.org  
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# updated to work with latest source from abrasive
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shairport
PKG_VERSION:=2.0
PKG_RELEASE:=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/mikebrady/shairport.git
PKG_SOURCE_VERSION:=HEAD
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS+= \
	--with-alsa \
	--with-avahi

define Build/Configure
	(cd $(PKG_BUILD_DIR); autoreconf -i)
	$(call Build/Configure/Default, )
endef

define Package/shairport/Default
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=ShairPort 2.0
endef


define Package/shairport
  $(Package/shairport/Default)
   DEPENDS:= +libpthread +libopenssl +libavahi-client +alsa-lib
endef

define Package/shairport/description
  ShairPort is server software that implements the RAOP protocol for
  playback of music streamed from a compatible remote client.
  This is ShairPort 2.0.
endef


define Package/shairport/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/shairport $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/init.d/airplay $(1)/etc/init.d/
	$(INSTALL_DATA) ./files/config/airplay $(1)/etc/config/
	$(INSTALL_DATA) ./files/asound.conf $(1)/etc/
endef


$(eval $(call BuildPackage,shairport))
