#!/bin/bash

## Because homebrew is dumb and Ansible requires it.

type autoconf 2>&1 >/dev/null
if [ $? -eq 1 ]; then
  brew install autoconf automake
fi

set -e

cd /tmp
git clone https://git.code.sf.net/p/sshpass/code-git sshpass-code-git
cd sshpass-code-git

./bootstrap
./configure --disable-debug \
  --disable-dependency-tracking \
  --disable-silent-rules \
  --prefix=/usr/local

make
echo "Enter password to install binary:"
sudo make install

cd ..
rm -rf sshpass-code-git

brew uninstall autoconf automake