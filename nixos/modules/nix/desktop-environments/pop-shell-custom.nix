{ pkgs, ... }:

{
  environment.systemPackages = [
    # Additional GNOME Extensions for Pop Shell
    pkgs.gnomeExtensions.emoji-copy
    pkgs.gnomeExtensions.notification-timeout

    # Allow generating Nix configs from dconf dumps
    pkgs.dconf2nix
  ];
}
