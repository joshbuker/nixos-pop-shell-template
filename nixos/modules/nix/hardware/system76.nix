{ config, pkgs, lib, ... }:

{
  options = {
    custom.system76.enable = lib.mkEnableOption "System76 hardware support";
  };

  config = lib.mkIf config.custom.system76.enable {
    hardware.system76.enableAll = true;

    environment.systemPackages = [
      pkgs.fwupd # Firmware updates
    ];
  };
}
