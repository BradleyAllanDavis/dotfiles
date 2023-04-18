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

  outputs = inputs @ { self, nixpkgs, nurpkgs, darwin, home-manager }:
    let
      pkgs-darwin = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      username = "bradley";
      userDescription = "Bradley Allan Davis";
      macHostName = "mac";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nurpkgs username userDescription;
        }
      );
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
