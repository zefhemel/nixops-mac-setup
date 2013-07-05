#!/bin/bash -e

source ~/.profile
echo "Installing NixOps"
cd ~
git clone git://github.com/NixOS/nixops.git
nix-env -I nixops -i nixops
