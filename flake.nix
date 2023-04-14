{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.11";                                 # Nix Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";             # Nix Packages (unstable)
    nur.url = "github:nix-community/NUR";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";                                 # Nix Packages
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {                                                            # Home Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, nixpkgs-darwin, darwin, home-manager }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-darwin = import nixpkgs-darwin {
        system = "x86_64-darwin";
        config.allowUnfree = true;
      };

      username = "bradley";
      userDescription = "Bradley Davis";
      desktopHostName = "desktop";
      macHostName = "mac";
    in {
      nixosConfigurations = {
        ${desktopHostName} = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/${desktopHostName}/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  ./home.nix
                ];
              };
            }
            nur.nixosModules.nur
          ];
        };
      };
      darwinConfigurations = {
        ${macHostName} = pkgs-darwin.lib.darwinSystem {
          inherit pkgs-darwin darwin;
          system = "x86_64-darwin";
          modules = [
            ./hosts/${macHostName}/nix.conf
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  #./home.nix
                ];
              };
            }
          ];
        };
      };
      hmConfig = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit pkgs-unstable username userDescription; };
          # extraSpecialArgs = { inherit pkgs-unstable; };
          modules = [
            ./home.nix
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
