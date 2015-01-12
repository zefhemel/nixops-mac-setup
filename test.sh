#!/bin/bash
nixops create test/trivial.nix test/trivial-vbox.nix --name test
nixops deploy -d test
nixops ssh -d test machine
