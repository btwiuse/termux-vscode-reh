#!/usr/bin/env -S bash

# date +%y%j
VERSION=25152
DISTRO=reh
DISTRO=reh-web
TGZ="vscodium-${DISTRO}-linux-arm64-1.100.0.${VERSION}.tar.gz"

# rm $TGZ
# download archive
[[ -f $TGZ ]] || {
  wget https://github.com/btwiuse/vscodium/releases/download/1.100.0.$VERSION/$TGZ
}

# extract archive
mkdir -vp $DISTRO
tar xf $TGZ -C $DISTRO

cd $DISTRO

# replace bundled node binary with local one
cp `which node` node

# if host is not linux
npm add node-pty

# if host is android termux, patch node-pty with custom build
cp ../termux-node-pty/build/Release/pty.node node_modules/node-pty/build/Release/

# ufo pub :8000 &
# ./bin/codium-server --without-connection-token --port 8000
./bin/code-server-oss --without-connection-token --port 8000
