#!/bin/bash -e

DIST="`pwd`"
DMG=~/NixStore.dmg

echo "Creating disk image"
hdiutil create -size 8G -fs "Case-sensitive HFS+" -volname NixStore $DMG
sudo mkdir -p /nix
sudo chown $USER /nix
./attach-disk.sh

echo "Downloading and installing Nix"
cd /
#curl http://hydra.nixos.org/build/6039370/download/1/nix-1.6-x86_64-darwin.tar.bz2 | sudo tar xjf -
curl http://hydra.nixos.org/build/17897581/download/1/nix-1.8-x86_64-darwin.tar.bz2 | sudo tar xjf -
./nix-1.8-x86_64-darwin/install
sudo chown -R $USER /nix
rm -f /usr/local/etc/profile.d/nix.sh
nix-finish-install

echo "Adding environment variables to ~/.profile"
RCFILE=~/.profile
echo "source ~/.nix-profile/etc/profile.d/nix.sh" >> $RCFILE

echo "Now logout and back in to use Nix, or source ~/.profile now."
