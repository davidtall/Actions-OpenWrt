#!/bin/bash

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

pushd package > /dev/null
rm -rf luci-theme*

git clone https://github.com/kenzok8/small-package
git clone https://github.com/kenzok8/small

mv small-package/luci-app-{passwall*,onliner,beardropper,iptvhelper,tcpdump,netdata,netspeedtest,\
supervisord,smartdns,ssr-plus,mosdns,adguardhome,dockerman,wrtbwmon,pushbot,\
argon-config,design-config,nginx-manager,ddns-go\
} small/

mv small-package/{aria*,ddnsgo,homebox,iptvhelper,mosdns,netdata,smartdns,wrtbwmon,v2dat,\
shadowsocks*\
} small/

rm -rf small-package
pushd small > /dev/null
git clone --depth 1 -b 18.06 https://github.com/kiddin9/luci-theme-edge
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone https://github.com/gngpp/luci-theme-design.git
#rm -rf luci-theme-edge/root/etc/uci-defaults/30_luci-theme-edge

#rm -rf upx*
#sed -i 's/+mosdns-v5/+mosdns/g' luci-app-mosdns/Makefile
popd
popd