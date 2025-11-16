{ config, lib, pkgs, ... }:

{
  options = {
    custom.bluetooth = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description =  "Enable Bluetooth support";
      };
    };
  };

  config = lib.mkMerge[
    (lib.mkIf config.custom.bluetooth.enable {
      # Enable Bluetooth support
      hardware.bluetooth.enable = true;

      # Disable Bluetooth power on boot if not gaming
      hardware.bluetooth.powerOnBoot = lib.mkDefault false;
    })

    (lib.mkIf (config.custom.bluetooth.enable && config.custom.gaming.enable) {
      # Enable Bluetooth power on boot
      hardware.bluetooth.powerOnBoot = true;

      # See: https://www.reddit.com/r/NixOS/comments/1hdsfz0/what_do_i_have_to_do_to_make_my_xbox_controller/

      # Set Bluetooth settings
      hardware.bluetooth.settings.General = {
        experimental = true; # Show battery status
        Privacy = "device"; # Privacy setting for device visibility
        JustWorksRepairing = "always"; # Always allow repairing without confirmation
        Class = "0x000100"; # Bluetooth class of device
        FastConnectable = true; # Enable fast connectable mode
      };

      # Enable Blueman for Bluetooth management
      services.blueman.enable = true;

      # Enable xpadneo driver for Xbox One wireless controllers
      hardware.xpadneo.enable = true;

      # Not sure what this does, but it seems to be the magic sauce for connecting Xbox One controllers
      boot.extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
      boot.extraModprobeConfig = ''
        options bluetooth disable_ertm=Y
      '';
    })
  ];
}
