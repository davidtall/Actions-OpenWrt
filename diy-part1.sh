#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

rm -rf package/custom
mkdir package/custom
cd package/custom

git clone --depth 1 https://github.com/kiddin9/luci-theme-edge
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git
rm -rf luci-theme-edge/root/etc/uci-defaults/30_luci-theme-edge


git clone --depth 1 https://github.com/kenzok8/wall && mv -n wall/* ./ ; rm -rf alist && rm -rf wall
git clone --depth 1 https://github.com/kiddin9/aria2
git clone --depth 1 https://github.com/ElvenP/luci-app-onliner
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper && mvdir openwrt-iptvhelper
git clone --depth 1 https://github.com/NateLol/luci-app-beardropper
git clone --depth 1 https://github.com/KFERMercer/luci-app-tcpdump
git clone -b 1.33.1 https://github.com/Jason6111/luci-app-netdata
git clone --depth 1 https://github.com/sundaqiang/openwrt-packages && mv -n openwrt-packages/luci-app-supervisord ./; rm -rf openwrt-packages
git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
#git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall && mv -n passwall/luci-app-passwall ./;rm -rf passwall
#git clone --depth 1 https://github.com/fw876/helloworld && mv -n helloworld/luci-app-ssr-plus helloworld/naiveproxy ./ ; rm -rf helloworld
git clone --depth 1 https://github.com/QiuSimons/openwrt-mos && mv -n openwrt-mos/luci-app-mosdns ./ ; rm -rf openwrt-mos
git clone --depth 1 https://github.com/sirpdboy/sirpdboy-package && mv -n sirpdboy-package/{luci-app-adguardhome,luci-app-dockerman} ./ ; rm -rf sirpdboy-package 
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon wrtbwmon1 && mvdir wrtbwmon1
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon wrtbwmon2 && mvdir wrtbwmon2

sed -i 's/+mosdns-v5/+mosdns/g' luci-app-mosdns/Makefile