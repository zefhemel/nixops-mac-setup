#!/bin/bash -e

echo "Installing NixOps"
. ~/.profile
nix-channel --add http://nixos.org/channels/nixos-unstable nixos
nix-channel --update
export NIX_PATH=/nix/var/nix/profiles/per-user/$USER/channels/nixos

# get the .nixpkg URL of the latest darwin build of nixops
URL=`curl -sL http://hydra.nixos.org/job/nixops/master/build.x86_64-darwin/latest | grep .nixpkg | grep href | grep -o \".*\" | sed s/\"//g`
nix-install-package --non-interactive --url $URL

RCFILE=~/.profile
echo "Adding environment variables to ~/.profile"
echo "export NIX_PATH=/nix/var/nix/profiles/per-user/$USER/channels/nixos" >> $RCFILE

