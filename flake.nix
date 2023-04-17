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
          specialArgs = { inherit username userDescription; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/${desktopHostName}/configuration.nix
            nur.nixosModules.nur
          ];
        };
      };
      hmConfig = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit username userDescription; };
          modules = [
            ./hosts/${desktopHostName}/home.nix
          ];
        };
      };
    };

}
