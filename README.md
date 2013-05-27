Simple one-off script to download and install Nix and NixOps and make it to prepare it for deployments on Mac.
Inspired by [these instructions](http://functional-orbitz.blogspot.se/2013/05/setting-up-nixops-on-mac-os-x-with.html).

Procedure
---------

1. Create a disk image with a case-sensitive file system and mount it at `/nix`.
2. Install Nix
3. Create and start a VirtualBox VM to be used to perform builds to be pushed to deployed servers (NixOSBuild)
4. Configure Nix to delegate Linux builds to the above NixOSBuild VM
5. Install NixOps

Requirements
------------
* No Nix installed yet, clean system (Nix-wise)
* Port 2222 available (used for port mapping the builder VM)
* XCode command line tools installed (make, gcc etc.)
* Virtualbox (Setup up virtualbox0 network)
* Git installed: http://git-scm.com/download/mac
