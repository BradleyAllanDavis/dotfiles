# macOS configuration

{ lib, inputs, nixpkgs, home-manager, darwin, username, userDescription, ... }:

let
  system = "aarch64-darwin";

  # pkgs = import nixpkgs {
  #   inherit system;
  #   config.allowUnfree = true;
  # };

  lib = nixpkgs.lib;

  macbookHostName = "mac";
in
{
  ${macbookHostName} = darwin.lib.darwinSystem {
    inherit system lib;
    # nixpkgs = pkgs;
    # specialArgs = { inherit username userDescription; };
    specialArgs = {
      inherit inputs lib username userDescription;
      # host = {
      #   hostName = "${macbookHostName}";
      # };
    };
    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit lib username userDescription; };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
          ];
        };
      }
    ];
  };
}
