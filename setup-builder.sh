#!/bin/bash -e

DIST="`pwd`"
RCFILE=~/.profile

echo "export NIX_BUILD_HOOK=$HOME/.nix-profile/libexec/nix/build-remote.pl" >> $RCFILE
echo "export NIX_CURRENT_LOAD=/tmp/current-load" >> $RCFILE
echo "export NIX_REMOTE_SYSTEMS=$HOME/.nix-remote-systems.conf" >> $RCFILE
mkdir -p /tmp/current-load

echo "Downloading Nix OS Builder image"
cd /tmp
curl -O http://nixops-mac.s3.amazonaws.com/NixOSBuilder.ova
echo "Installing Nix OS Builder"
VBoxManage import NixOSBuilder.ova
VBoxManage startvm NixOSBuilder
rm NixOSBuilder.ova

echo "Setting up remote builds"
mkdir -p ~/.ssh
echo "Host nix-build-server" >> ~/.ssh/config
echo "    HostName localhost" >> ~/.ssh/config
echo "    Port 2222" >> ~/.ssh/config

echo "nix@nix-build-server x86_64-linux $DIST/id_rsa 1 1" > ~/.nix-remote-systems.conf
echo '[localhost]:2222 ssh-dss AAAAB3NzaC1kc3MAAACBAJYMUIA8H7Wh0acd4JTiWu92Efd90cd3YM3NszJNPBtUrTJUYNMxCz09lJp1K2I7N8LxS0QBT4xv8WGCWcLZJ4rpP5q3ORm/9sW05FoL/+70Rr+Jc4S4bMaHcVJf73Pre2T6XjCd3YxXtD6m8E0lFiXhhFCi3loN8druPaLPtsLfAAAAFQCV6JeqHAZTavW0ZcapU45FnvuVJQAAAIAz5gWbNFo4D3/YC+0/DbU5gPAj+O0tRRDbXRcvRP/V7+7ttfgC0Nbxpq81MUr8P3P4ntasrCT1AzAiEGARPdnuCUXjwz/5KHNxwzYTcohCmpbTzp+kvk5i/LzyxW0IowSGWrxa0PQJUHdE0BMXtoEax/q8JxLpoil6XNgVkn6TNgAAAIBNo9NBWyZ88ShGQbk6vC2FB97P1Jf61T/O9VYZ9qchKodyLLpKIDKuwG2zkytioDB+BEQttsyVCzvdmTNoRPYkyMdGP3ddIajcPuSTSOo2brmGp8E5/AFZN+uGQaVbvO0pBx7YGqUW+VOxA9Tu69PJy0E3LzFGPaYoknj81nna9w==' >> ~/.ssh/known_hosts

echo "Installing keys"
sudo mkdir -p /etc/nix
sudo chown -R $USER /etc/nix
cp $DIST/id_rsa /etc/nix/signing-key.sec
cp $DIST/signing-key.pub /etc/nix/signing-key.pub
mkdir -p /tmp/current-load
