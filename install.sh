#!/bin/bash -e

./install-nix.sh
./setup-builder.sh
./install-nixops.sh

echo "Should be all done."
echo "To get started, just source your ~/.profile:"
echo "  source ~/.profile"

