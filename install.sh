#!/bin/bash -e

./install-nix.sh
./install-nixops.sh

echo "Please reload your ~/.profile to put nix / nixops in your path:"
echo "  source ~/.profile"

