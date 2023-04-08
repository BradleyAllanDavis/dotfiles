{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

      user = "bradley";
      userDescription = "Bradley";
    in {
      nixosConfigurations = {
        ${user} = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
      hmConfig = {
        ${user} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            {
              home = {
                username = "${user}";
                homeDirectory = "/home/${user}";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
    };

}
