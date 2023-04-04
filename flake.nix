{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.11";
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
    in {
      nixosConfigurations = {
        bradley = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./configuration.nix
          ];
        };
      };
      hmConfig = {
        bradley = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            {
              home = {
                username = "bradley";
                homeDirectory = "/home/bradley";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
    };

}
