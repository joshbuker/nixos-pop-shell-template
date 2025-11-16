# Minimal additional config needed to bootstrap a fresh NixOS Install

{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "alice" ];
  };

  # Install Git, VS Code, and Bat
  environment.systemPackages = [
    pkgs.git    # Used for cloning dotfiles during bootstrap
    pkgs.vscode # Used for editing configuration.nix during bootstrap
    pkgs.bat    # Used in the rebuild script
  ];

  # Install GnuPG with SSH Support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable SmartCard udev rules
  hardware.gpgSmartcards.enable = true;

  # Enable nix flakes for rebuild script
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
