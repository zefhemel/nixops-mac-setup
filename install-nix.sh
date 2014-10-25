#!/bin/bash -e

DIST="`pwd`"
DMG=~/NixStore.dmg

echo "Creating disk image"
hdiutil create -size 20G -fs "Case-sensitive HFS+" -volname NixStore $DMG
sudo mkdir -p /nix
sudo chown $USER /nix
./attach-disk.sh

echo "Downloading and installing Nix"
cd /tmp
curl https://nixos.org/releases/nix/nix-1.7/nix-1.7-x86_64-darwin.tar.bz2 | tar xjf -
nix-1.7-x86_64-darwin/install
rm -rf nix-1.7-x86_64-darwin
. ~/.nix-profile/etc/profile.d/nix.sh
nix-env -u nix


