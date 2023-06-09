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
      ./base-configuration.nix
      ./${desktopHostName}
      nurpkgs.nixosModules.nur

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
            ./${desktopHostName}/home.nix
          ];
        };
      }
    ];
  };
  ${laptopHostName} = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs username userDescription;
      hostName = laptopHostName;
      host = {
        hostName = "${laptopHostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${laptopHostName}

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${laptopHostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            ./${laptopHostName}/home.nix
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
      ./base-configuration.nix
      ./${serverHostName}
      nurpkgs.nixosModules.nur

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
            ./${serverHostName}/home.nix
          ];
        };
      }
    ];
  };
}
