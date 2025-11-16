# For nvidia gpu laptops with integrated graphics, additional config needed!
# https://nixos.wiki/wiki/Nvidia
# You will need to do the other config in configuration.nix for that laptop!

{ config, lib, pkgs, ... }:

{
  options = {
    custom.nvidia.enable = lib.mkEnableOption "Nvidia GPU support";
    custom.nvidia.newGpu = lib.mkEnableOption "Enable support for new Nvidia GPUs (Turing and newer)";
  };

  config = lib.mkMerge[
    (lib.mkIf config.custom.nvidia.enable {
      # Install lshw for determining Optimus PRIME values on new machines
      environment.systemPackages = [
        pkgs.lshw # See: https://nixos.wiki/wiki/Nvidia
        pkgs.nvtopPackages.nvidia # Nvidia GPU monitoring tool, run with `nvtop`
      ];

      # Enable OpenGL
      hardware.graphics = {
        enable = true;
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = lib.mkDefault false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        open = lib.mkDefault false;
        # ^ Enable this on GPUs that support it! Disabled by default for support of older gpus (like 1080ti)

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    })

    (lib.mkIf (config.custom.nvidia.enable && config.custom.nvidia.newGpu) {
      # Enable support for new Nvidia GPUs (Turing and newer)
      hardware.nvidia.open = true;
    })
  ];
}
