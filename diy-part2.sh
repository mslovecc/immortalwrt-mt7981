#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# extend TP-link firmware size
sed -i 's/tplink-4m/tplink-8m/g' target/linux/ar71xx/image/tiny-tp-link.mk
sed -i 's/tplink-4mlzma/tplink-8mlzma/g' target/linux/ar71xx/image/tiny-tp-link.mk

# extend Netgear firmware size
sed -i 's/3712k(firmware)/7808k(firmware)/g' target/linux/ar71xx/image/legacy.mk

# Fix Material theme progressbar font size
sed -i 's/1.3em/1em/g' package/feeds/luci/luci-theme-material/htdocs/luci-static/material/cascade.css

# Enable wifi
sed -i 's/.disabled=1/.disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Set Wifi SSID and Password
sed -i 's/.ssid=OpenWrt/.ssid=Tomato24/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/.encryption=none/.encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set\ wireless.default_radio${devidx}.encryption=psk-mixed/a set\ wireless.default_radio${devidx}.key=Psn@2416' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# DHCP defaults
sed -i 's/100/10/g' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/150/25/g' package/network/services/dnsmasq/files/dhcp.conf

## Enable vlmcsd auto activation
echo srv-host=_vlmcs._tcp.lan,OpenWrt.lan,1688,0,100 >> package/network/services/dnsmasq/files/dnsmasq.conf

# Set default root password
sed -i 's/root::0:0:99999:7:::/root:$1$kWRCl0Y2$7JL\/jLAF1xoVIiIMdTO5f.:16788:0:99999:7:::/g' package/base-files/files/etc/shadow
