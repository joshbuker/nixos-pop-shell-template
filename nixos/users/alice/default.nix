{
  users.users.alice = {
    isNormalUser = true;
    description = "Alice Example";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

  home-manager.users.alice = ./home.nix;
}
