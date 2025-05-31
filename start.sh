#!/usr/bin/env -S bash

# date +%y%j
VERSION=25152
DISTRO=reh
DISTRO=reh-web
TGZ="vscodium-${DISTRO}-linux-arm64-1.100.0.${VERSION}.tar.gz"
TERMUX_NODE_PTY=../termux-node-pty/build/Release/pty.node

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
[[ "$(uname)" != Linux ]] && {
  npm add node-pty vscode-regexpp cookie @vscode/ripgrep @vscode/proxy-agent @xterm/headless @xterm/addon-unicode11
}

# if host is android termux, patch node-pty with custom build
[[ -f $TERMUX_NODE_PTY ]] && {
  cp -v $TERMUX_NODE_PTY node_modules/node-pty/build/Release/
}

# ufo pub :8000 &
# ./bin/codium-server --without-connection-token --port 8000
./bin/code-server-oss --without-connection-token --port 8000
