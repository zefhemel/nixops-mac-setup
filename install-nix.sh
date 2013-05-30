#!/bin/bash -e

DIST="`pwd`"
DMG=~/NixStore.dmg

echo "Creating disk image"
hdiutil create -size 10G -fs "Case-sensitive HFS+" -volname NixStore $DMG
sudo mkdir -p /nix
sudo chown $USER /nix
./attach-disk.sh

echo "Downloading and installing Nix"
cd /
curl http://hydra.nixos.org/build/4954118/download/1/nix-1.5.2-x86_64-darwin.tar.bz2 | sudo tar xjf -
sudo chown -R $USER /nix
rm -f /usr/local/etc/profile.d/nix.sh
nix-finish-install

echo "Adding environment variables to ~/.profile"
RCFILE=~/.profile
echo "source ~/.nix-profile/etc/profile.d/nix.sh" >> $RCFILE
echo "export NIX_PATH=/nix/var/nix/profiles/per-user/$USER/channels/nixos" >> $RCFILE

source $RCFILE

nix-channel --add http://nixos.org/releases/nixos/channels/nixos-unstable nixos
nix-channel --add http://hydra.nixos.org/jobset/nix/trunk/channel/latest nix
nix-channel --update
echo Upgrading Nix
nix-env -i nix
