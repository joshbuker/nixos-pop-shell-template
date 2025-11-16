{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.dunst # Notification Daemon
  ];
}
