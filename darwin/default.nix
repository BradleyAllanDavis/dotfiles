# macOS configuration

{ inputs, lib, nixpkgs, home-manager, darwin, username, userDescription, ... }:

let
  system = "aarch64-darwin";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  macbookHostName = "macbook";
in
{
  ${macbookHostName} = darwin.lib.darwinSystem {
    inherit system lib pkgs;
    specialArgs = {
      inherit inputs username userDescription;
      hostName = macbookHostName;
      host = {
        hostName = "${macbookHostName}";
      };
    };
    modules = [
      ./configuration.nix
      ./preferences.nix
      ./brew.nix

      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit username userDescription;
          host = {
            hostName = "${macbookHostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
          ];
        };
      }
    ];
  };
}
