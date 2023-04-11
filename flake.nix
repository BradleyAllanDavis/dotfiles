{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.11";                                 # Nix Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";             # Nix Packages (unstable)
    nur.url = "github:nix-community/NUR";

    home-manager = {                                                            # Home Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, home-manager }:
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

      userName = "bradley";
      # userDescription = "Bradley";
      hostName = "desktop";
    in {
      nixosConfigurations = {
        ${hostName} = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userName} = {
                imports = [ ./home.nix ];
              };
            }
            # nur.nixosModules.nur
          ];
        };
      };
      hmConfig = {
        ${userName} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # extraSpecialArgs = { inherit pkgs-unstable userName userDescription; };
          extraSpecialArgs = { inherit pkgs-unstable; };
          modules = [
            ./home.nix
            {
              home = {
                username = "${userName}";
                homeDirectory = "/home/${userName}";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
    };

}
