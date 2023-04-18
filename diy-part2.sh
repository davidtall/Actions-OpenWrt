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
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

mv feeds/luci/themes/luci-theme-bootstrap feeds/luci/themes/luci-bak-bootstrap
rm -rf feeds/luci/themes/luci-theme-*
mv feeds/luci/themes/luci-bak-bootstrap feeds/luci/themes/luci-theme-bootstrap

rm -rf feeds/packages/lang/golang
svn export https://github.com/coolsnowwolf/packages/trunk/lang/golang feeds/packages/lang/golang

rm -rf feeds/luci/applications/luci-app-{passwall,mosdns,dockerman}
rm -rf feeds/packages/net/{shadowsocks*,xray*,v2ray*,mosdns,aria*}
cp -Rp package/small-package/{aria*,shadowsocks*,xray*,v2ray*,mosdns} feeds/packages/net/