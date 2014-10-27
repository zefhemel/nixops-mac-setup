#!/bin/bash

nixops ssh-for-each "if test -z \"`nix-env --version | grep '(Nix) 1.7'`\"; then nix-install-package --non-interactive --url `curl -sL http://hydra.nixos.org/job/nix/master/build.x86_64-linux/latest | grep .nixpkg | grep href | grep -o \".*\" | sed s/\"//g`; fi"
