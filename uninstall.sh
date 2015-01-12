#!/bin/bash

hdiutil detach /nix
sudo rm -rf /nix
rm -rf ~/.nix*
rm ~/NixStore.dmg
rm -rf ~/nixops
