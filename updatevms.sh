#!/bin/bash

nixops ssh-for-each "if test -z \"`nix-env --version | grep 1.7`\"; then nix-channel --add https://nixos.org/channels/nixos-unstable && nix-channel --update && nix-env -i nix; fi"
