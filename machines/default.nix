{ inputs, nixpkgs, home-manager, nurpkgs, username, userDescription, hosts, ... }:

let
  system = "x86_64-linux";
  lib = nixpkgs.lib;

  stateVersion2211 = "22.11";
  stateVersion2305 = "23.05";
  stateVersion2311 = "23.11";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  desktopHostName = "desktop";
  framework13HostName = "framework13";
  framework16HostName = "framework16";
  serverHostName = "server";
  routerHostName = "router";

  base-packages = import ../packages/base-packages.nix;
  nixos-packages = import ../packages/nixos-packages.nix;
  gui-packages = import ../packages/gui-packages.nix;
  laptop-packages = import ../packages/laptop-packages.nix;
in
{
  ${desktopHostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      stateVersion = "${stateVersion2211}";
      hostName = desktopHostName;
      host = {
        hostName = "${desktopHostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${desktopHostName}
      nurpkgs.nixosModules.nur
      ../modules/stevenBlackHosts

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
          home = {
            stateVersion = "${stateVersion2211}";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
          };
        };
      }
    ];
  };
  ${framework13HostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      stateVersion = "${stateVersion2211}";
      hostName = framework13HostName;
      host = {
        hostName = "${framework13HostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${framework13HostName}
      # ../modules/bitcoin
      # nurpkgs.nixosModules.nur

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${framework13HostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
          ];
          home = {
            stateVersion = "${stateVersion2211}";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs) ++ (laptop-packages pkgs);
          };
        };
      }
    ];
  };
  ${framework16HostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      stateVersion = "${stateVersion2311}";
      hostName = framework16HostName;
      host = {
        hostName = "${framework16HostName}";
      };
    };
    modules = [
      ./base-configuration.nix
      ./${framework16HostName}
      # nurpkgs.nixosModules.nur

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs username userDescription;
          host = {
            hostName = "${framework16HostName}";
          };
        };
        home-manager.users.${username} = {
          imports = [
            ./home.nix
          ];
          home = {
            stateVersion = "${stateVersion2311}";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs) ++ (laptop-packages pkgs);
          };
        };
      }
    ];
  };
  ${routerHostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      stateVersion = "${stateVersion2305}";
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
            stateVersion = "${stateVersion2305}";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
          };
        };
      }
    ];
  };
  ${serverHostName} = lib.nixosSystem {
    specialArgs = {
      inherit system inputs username userDescription;
      stateVersion = "${stateVersion2311}";
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
            stateVersion = "${stateVersion2211}";
            packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
          };
        };
      }
    ];
  };
}
