{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nurpkgs.url = "github:nix-community/NUR";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nurpkgs, darwin, home-manager }:
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
      nixosConfigurations = {
        ${desktopHostName} = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit username userDescription; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/${desktopHostName}/configuration.nix
            nurpkgs.nixosModules.nur
          ];
        };
      };
      darwinConfigurations = {
        ${macHostName} = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = pkgs-darwin;
          modules = [
            home-manager.darwinModules.home-manager
            ./hosts/${macHostName}
          ];
        };
      };
    };

}
