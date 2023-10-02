{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
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

  outputs = { self, nixpkgs, nurpkgs, darwin, home-manager, ... }@inputs:
  let
    username = "bradley";
    userDescription = "Bradley Allan Davis";

    createDevShell = system: let
      pkgs = import nixpkgs { inherit system; };
    in
      pkgs.mkShell {
        buildInputs = with pkgs; [
          just
        ];
      };
  in {
    devShell.x86_64-linux = createDevShell "x86_64-linux";
    devShell.aarch64-linux = createDevShell "aarch64-linux";
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager nurpkgs username userDescription;
      }
    );
    darwinConfigurations = (
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin username userDescription;
      }
    );
  };

}
