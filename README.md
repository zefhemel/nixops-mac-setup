Simple one-off script to download and install Nix and NixOps and make it to prepare it for deployments on Mac.
Inspired by [these instructions](http://functional-orbitz.blogspot.se/2013/05/setting-up-nixops-on-mac-os-x-with.html).

Procedure
---------
The script executes the following steps:

1. Create a disk image with a case-sensitive file system and mount it at `/nix`.
2. Install Nix and append environment variable setup to `~/.profile`
5. Install NixOps

Requirements
------------
* No Nix installed yet, clean system (Nix-wise)
* XCode command line tools installed (make, gcc etc.)
  * On 10.9, use XCode 5.1.x
  * On 10.10, use XCode 6.x
* Virtualbox (for deployments to VirtualBox)
* Git installed: http://git-scm.com/download/mac

Use
----

First, configure VirtualBox ([source](http://functional-orbitz.blogspot.se/2013/05/setting-up-nixops-on-mac-os-x-with.html)):

* Start VirtualBox.
* Go to preferences (Cmd-,).
* Click on Network / Host-only Networks.
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
	nixops ssh -d test machine

After you reboot the `NixStore.dmg` will not automatically be remounted to mount it again, run `./attach-disk.sh` again.

Resizing NixStore.dmg
---------------------

By default the NixStore.dmg file is 10G which should be enough for a while, if you want resize it, play with these commands:

    hdiutil detach /nix
    hdiutil resize -size 50g NixStore.dmg
    hdiutil attach NixStore.dmg -mountpoint /nix

