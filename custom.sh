#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: Custom.sh
# Description: OpenWrt Custom script
#
# Vlmcsd auto activation enabled
echo srv-host=_vlmcs._tcp.lan,OpenWrt.lan,1688,0,100 >> /etc/dnsmasq.conf

# 解决Kmod相关软件包无法安装问题，刷入系统后使/usr/lib/opkg/status中的hash和安装kmod软件包时出错的hash一致。
sed -i 's/060d4a88a59ff936e5d09f59b94a0195/b70ee1516753f10c063dd361f74167d4/g' /usr/lib/opkg/status
