{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nix
      ../../users
    ];

  networking.hostName = "example-laptop"; # Define your hostname.

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Unlock any additional LUKS partitions beyond root - https://nixos.wiki/wiki/Full_Disk_Encryption
  # These will try the same passphrase as the root partition automatically
  # Unlock Swap Partition
  boot.initrd.luks.devices."luks-some-long-string".device = "/dev/disk/by-uuid/some-long-string";
  # Unlock Steam Secondary Drive Partition
  boot.initrd.luks.devices."steam".device = "/dev/disk/by-uuid/another-long-string";
  # Will be available for mounting as /dev/mapper/steam

  # Add steam drive
  fileSystems."/mnt/steam" =
    { device = "/dev/mapper/steam";
      fsType = "ext4";
    };

  # Computer specific options.
  custom.system76.enable = true;
  custom.nvidia.enable = true;
  custom.nvidia.newGpu = false;
  custom.gaming.enable = true;

  # Laptop specific GPU config
  # Use `sudo lshw -c display` to find this for new machines, see: https://nixos.wiki/wiki/Nvidia
  hardware.nvidia.prime = {
    sync.enable = true; # Keep GPU enabled at all times (needed for gpu ports to work on Oryx Pro)

    # Set the bus IDs for the Intel and Nvidia GPUs.
    intelBusId = "PCI:0:2:0"; # pci@0000:00:02.0 -> PCI:0:2:0
    nvidiaBusId = "PCI:1:0:0"; # pci@0000:01:00.0 -> PCI:1:0:0
  };
}
