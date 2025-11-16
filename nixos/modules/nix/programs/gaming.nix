{ config, pkgs, lib, ... }:

{
  options = {
    custom.gaming.enable = lib.mkEnableOption "Gaming support";
  };

  config = lib.mkIf config.custom.gaming.enable {
    # Install steam
    programs.steam.enable = true;

    # environment.systemPackages = [
    #   pkgs.unstable.runelite
    #   pkgs.unstable.zeroad
    # ];
  };
}
