{
  # Description isn't important, change it to whatever you like
  description = "NixOS Pop Shell Template Flake";

  inputs = {
    # Nixpkgs - Stable 25.05 release
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Home Manager - Stable 25.05 release
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Nixpkgs Unstable - Rolling release
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    claude-desktop,
    # flake-utils,
    ...
  }@inputs:

  let
    mkSystem = hostname: # hostname: is a positional argument
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/${hostname}/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

    hosts = [
      { hostname = "example-desktop"; }
      { hostname = "example-laptop"; }
    ];
  in
  {
    # This is what creates the NixOS configurations for each host
    nixosConfigurations = builtins.listToAttrs (
      # Iterator - nixConfigurations.<name> = <value>
      map (host: {
        name = host.hostname;
        value = mkSystem host.hostname;
      })
      # Array to iterate over
      hosts
    );
  };
}
