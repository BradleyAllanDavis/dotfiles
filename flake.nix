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

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nur, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      user = "bradley";
      userDescription = "Bradley";
    in {

      # defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      # defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

      nixosConfigurations = {
        ${user} = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            nur.nixosModules.nur
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
          extraSpecialArgs = { inherit pkgs-unstable; };
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
