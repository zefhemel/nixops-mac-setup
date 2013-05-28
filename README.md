Simple one-off script to download and install Nix and NixOps and make it to prepare it for deployments on Mac.
Inspired by [these instructions](http://functional-orbitz.blogspot.se/2013/05/setting-up-nixops-on-mac-os-x-with.html).

Procedure
---------
The script executes the following steps:

1. Create a disk image with a case-sensitive file system and mount it at `/nix`.
2. Install Nix and append environment variable setup to `~/.profile`
3. Create and start a VirtualBox VM to be used to perform builds to be pushed to deployed servers (NixOSBuild)
4. Configure Nix to delegate Linux builds to the above NixOSBuild VM
5. Install NixOps

Requirements
------------
* No Nix installed yet, clean system (Nix-wise)
* Port 2222 available to bind to (used for port mapping the builder VM)
* XCode command line tools installed (make, gcc etc.)
* Virtualbox
* Git installed: http://git-scm.com/download/mac

Use
----

First, configure VirtualBox ([source](http://functional-orbitz.blogspot.se/2013/05/setting-up-nixops-on-mac-os-x-with.html)):

* Start VirtualBox.
* Go to preferences (Cmd-,).
* Click on Network.
* If vboxnet0 is not present, add it by clicking the green +.
* Edit vboxnet0 and make sure DHCP Server is turned on. The settings I use are below.
  * Server Address: 192.168.56.100
  * Server Mask: 255.255.255.0
  * Lower Address Bound: 192.168.56.101
  * Upper Address Bound: 192.168.56.254

Then, check out this repository in a terminal and run the install script:

    git clone git://github.com/zefhemel/nixos-mac-setup.git
    cd nixos-mac-setup
    ./install.sh

To test:

    nixops create test/trivial.nix test/trivial-vbox.nix --name test
    nixops deploy -d test

After you reboot the `NixStore.dmg` will not automatically be remounted to mount it again, run `./attach-disk.sh` again.

Resizing NixStore.dmg
---------------------

By default the NixStore.dmg file is 10G which should be enough for a while, if you want resize it, play with these commands:

    hdiutil detach /nix
    hdiutil resize -size 50g NixStore.dmg
    hdiutil attach NixStore.dmg -mountpoint /nix

