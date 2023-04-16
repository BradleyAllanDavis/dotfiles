{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, darwin, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-darwin = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      username = "bradley";
      userDescription = "Bradley Allan Davis";
      desktopHostName = "desktop";
      macHostName = "mac";
    in {
      darwinConfigurations = {
        ${macHostName} = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = pkgs-darwin;
          modules = [
            home-manager.darwinModules.home-manager
            ./hosts/${macHostName}/default.nix
          ];
        };
      };
      nixosConfigurations = {
        ${desktopHostName} = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./hosts/${desktopHostName}/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  ./hosts/${desktopHostName}/home.nix
                ];
              };
            }
            nur.nixosModules.nur
          ];
          # inputs = { inherit username userDescription; };
        };
      };
      hmConfig = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit username userDescription; };
          modules = [
            ./hosts/desktop/home.nix
            {
              home = {
                username = "${username}";
                homeDirectory = "/home/${username}";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
    };

}
