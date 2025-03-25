#!/bin/sh
set -e

echo "###############################################"
echo "## Configuring Git                           ##"
echo "###############################################"

git config --global --add safe.directory /host
git config --global credential.helper store
echo "https://${GIT_USER}:${GIT_PASSWORD}@git.intelbras.com.br" > ~/.git-credentials

echo "###############################################"
echo "## Building the Archives                     ##"
echo "###############################################"
make tools/clean
make package/utils/jsonfilter/clean
make package/feeds/simetbox/simetbox-openwrt-simet-lmapd/clean
make package/feeds/simetbox/simetbox-openwrt-simet-ma/clean
make package/system/procd/clean
make package/system/rpcd/clean
make package/utils/util-linux clean
make package/feeds/packages/qrencode/clean 
make tools/compile V=s
make tools/install V=s
make package/utils/jsonfilter/compile V=s
make package/feeds/simetbox/simetbox-openwrt-simet-lmapd/compile V=s
make package/feeds/simetbox/simetbox-openwrt-simet-ma/compile V=s
make package/system/procd/compile V=s
make package/system/rpcd/compile V=s
make package/feeds/packages/qrencode/compile V=s
make package/utils/util-linux/compile V=s

echo "###############################################"
echo "## Build finished                            ##"
echo "###############################################"

cp -r /host/includes/* /host/staging_dir/target-aarch64-openwrt-linux-musl_musl/root-mediatek/

cp /host/staging_dir/target-aarch64-openwrt-linux-musl_musl/root-mediatek/usr/bin/flock /host/staging_dir/target-aarch64-openwrt-linux-musl_musl/root-mediatek/usr/bin/util-linux-flock

echo "###############################################"
echo "## Compressing Output File...                ##"
echo "###############################################"

mkdir -p /host/output
tar -czvf /host/output/root-mediatek.tar.gz -C /host/staging_dir/target-aarch64-openwrt-linux-musl_musl/root-mediatek .