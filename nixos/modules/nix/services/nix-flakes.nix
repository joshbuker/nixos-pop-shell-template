{ config, pkgs, lib, ... }:

{
  # Allow using flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
