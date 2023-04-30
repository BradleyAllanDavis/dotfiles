# NixOS host configuration

{ lib, inputs, nixpkgs, home-manager, nurpkgs, username, userDescription, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

  desktopHostName = "desktop";
  serverHostName = "server";
  laptopHostName = "laptop";
in
{
  ${desktopHostName} = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs username userDescription;
      hostName = desktopHostName;
      host = {
        hostName = "${desktopHostName}";
      };
    };
    modules = [
      nurpkgs.nixosModules.nur
      ./${desktopHostName}
      # ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${desktopHostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            # ./${desktopHostName}/home.nix
          ];
        };
      }
    ];
  };
  ${serverHostName} = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs username userDescription;
      hostName = serverHostName;
      host = {
        hostName = "${serverHostName}";
      };
    };
    modules = [
      nurpkgs.nixosModules.nur
      ./${serverHostName}
      # ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${serverHostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            # ./${serverHostName}/home.nix
          ];
        };
      }
    ];
  };

}
