{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.networkmanager
    pkgs.networkmanagerapplet
    pkgs.wireguard-tools # Allows using wg and wg-quick commands
  ];

  # Enable networking via NetworkManager
  networking.networkmanager.enable = true;

  # Allow wireguard connections through firewall
  # See: https://wiki.nixos.org/w/index.php?title=WireGuard#NetworkManager_Proxy_client_setup
  networking.firewall.checkReversePath = "loose";
}
