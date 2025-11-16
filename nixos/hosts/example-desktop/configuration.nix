{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nix
      ../../users
    ];

  networking.hostName = "example-desktop"; # Define your hostname.

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-some-long-string".device = "/dev/disk/by-uuid/some-long-string";

  # Computer specific options.
  custom.nvidia.enable = true;
  custom.gaming.enable = true;
  custom.users.bob.enable = true;

  # https://www.reddit.com/r/NixOS/comments/lcbz8x/nixos_slow/
  powerManagement.cpuFreqGovernor = "performance";

  ##########################################################
  ## Workaround for Nvidia suspend/hibernate black screen ##
  ##########################################################

  # https://discourse.nixos.org/t/black-screen-after-suspend-hibernate-with-nvidia/54341/6
  systemd.services."systemd-suspend" = {
    serviceConfig = {
      Environment=''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
    };
  };

  # https://discourse.nixos.org/t/black-screen-after-suspend-hibernate-with-nvidia/54341/23
  hardware.nvidia.powerManagement.enable = true;
}
