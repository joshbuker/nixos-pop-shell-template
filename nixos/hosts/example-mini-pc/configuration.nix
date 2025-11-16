{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nix
      ../../users
    ];

  networking.hostName = "example-mini-pc"; # Define your hostname.

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Unlock swap partition
  boot.initrd.luks.devices."luks-some-long-string".device = "/dev/disk/by-uuid/some-long-string";

  # Computer specific options
  custom.system76.enable = true;
  custom.users.bob.enable = true;
}
