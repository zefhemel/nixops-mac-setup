#!/bin/bash -e

echo "Installing NixOps"
cd ~
git clone git://github.com/NixOS/nixops.git
nix-env -I nixops -i nixops
nix-channel --add http://nixos.org/channels/nixos-unstable
nix-channel --update
export NIX_PATH=/nix/var/nix/profiles/per-user/$USER/channels/nixos

# echo "Adding environment variables to ~/.profile"
RCFILE=~/.profile
echo "export NIX_PATH=/nix/var/nix/profiles/per-user/$USER/channels/nixos" >> $RCFILE

