{ config, pkgs, ... }:
{
  require = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos-builder"; # Define your hostname.
  fileSystems."/".device = "/dev/disk/by-label/nixos";
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  services.openssh.enable = true;

  users.extraUsers.nix = {
    createHome = true;
    description = "Builder user";
    home = "/home/nix";
    shell = "/bin/sh";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvBdkHxHAlF7SDZ+Y2NYINwQGAs6D2SIGnU49uUQFrh3ISDhgUE7bk50B/c6pNlM30EWeD2Dx67msdmob9K5eZv6RpArqMMJtKnHdkHLAYdQZdfs4OdNIHWqadCLfqR9gDV9ItJtssyvboVqRStJ1GZ2gqNqB9zEXpKAbowhHnzUjs3lRmN0uOg8pOKEfoBAtWIdOMeJ7Ftvd3dPRsas8lJx/h64GJf55K8g3DCQDw+vbssId1eru41dpyvHNldzRecZv8oGKyJ5z9uNz4mje3tulcel991I20vgXnyQs00O1u8E3XQkrGk0c8Lm68fVNO9akBNf4uoJW/aDkAMJ7p"];
  };
}
