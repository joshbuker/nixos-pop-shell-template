{ config, pkgs, lib, inputs, ... }:

{
  options = {
    custom.users.bob.enable = lib.mkEnableOption "Enable Bob's user account";
  };

  config = lib.mkIf config.custom.users.bob.enable {
    # Don't forget to use `passwd` to set the password after bootstrapping the system.
    users.users.bob = {
      isNormalUser = true;
      description = "Bob Example";
      extraGroups = [ "networkmanager" ];
      packages = [];
    };

    home-manager.users.bob = ./home.nix;
  };
}
