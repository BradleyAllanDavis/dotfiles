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
  laptop13HostName = "laptop13";
  laptop16HostName = "laptop16";
  serverHostName = "server";
  routerHostName = "router";
in
{
  ${desktopHostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
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
  ${laptop13HostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      hostName = laptop13HostName;
      host = {
        hostName = "${laptop13HostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${laptop13HostName}
      # nurpkgs.nixosModules.nur

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${laptop13HostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            ./${laptop13HostName}/home.nix
          ];
        };
      }
    ];
  };
  ${laptop16HostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      hostName = laptop16HostName;
      host = {
        hostName = "${laptop16HostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${laptop16HostName}
      # nurpkgs.nixosModules.nur

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${laptop16HostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            ./${laptop16HostName}/home.nix
          ];
        };
      }
    ];
  };
  ${serverHostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      hostName = serverHostName;
      host = {
        hostName = "${serverHostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${serverHostName}
      # nurpkgs.nixosModules.nur

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
  ${routerHostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      hostName = routerHostName;
      host = {
        hostName = "${routerHostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${routerHostName}
      # nurpkgs.nixosModules.nur

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${routerHostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            ./${routerHostName}/home.nix
          ];
        };
      }
    ];
  };
}
