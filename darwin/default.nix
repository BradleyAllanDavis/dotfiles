# macOS configuration

{ lib, inputs, nixpkgs, home-manager, darwin, username, userDescription, ... }:

let
  system = "aarch64-darwin";

  pkgs-darwin = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  macbookHostName = "mac";
in
{
  ${macbookHostName} = darwin.lib.darwinSystem {
    inherit system;
    pkgs = pkgs-darwin;
    specialArgs = { inherit username inputs; };
    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit username userDescription; };
        home-manager.users.${username} = [
          ./home.nix
        ];
      }
    ];
  };
}
