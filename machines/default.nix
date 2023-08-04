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

  base-packages = import ../packages/base-packages.nix;
  nixos-packages = import ../packages/nixos-packages.nix;
  gui-packages = import ../packages/gui-packages.nix;
  laptop-packages = import ../packages/laptop-packages.nix;
in
{
  ${desktopHostName} = lib.nixosSystem {
    system.stateVersion = "22.11";
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
          ];
          home = {
            stateVersion = "22.11";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
          };
        };
      }
    ];
  };
  ${laptop13HostName} = lib.nixosSystem {
    system.stateVersion = "22.11";
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
          ];
          home = {
            stateVersion = "22.11";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs) ++ (laptop-packages pkgs);
          };
        };
      }
    ];
  };
  ${laptop16HostName} = lib.nixosSystem {
    system.stateVersion = "23.05";
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
          ];
          home = {
            stateVersion = "23.05";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs) ++ (laptop-packages pkgs);
          };
        };
      }
    ];
  };
  ${routerHostName} = lib.nixosSystem {
    system.stateVersion = "23.05";
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
          ];
          home = {
            stateVersion = "23.05";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
          };
        };
      }
    ];
  };
  ${serverHostName} = lib.nixosSystem {
    system.stateVersion = "22.11";
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
          ];
          home = {
            stateVersion = "22.11";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
          };
        };
      }
    ];
  };
}
