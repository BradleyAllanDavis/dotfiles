{
  description = "My $HOME";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";                                 # Nix Packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";             # Nix Packages (unstable)
    nur.url = "github:nix-community/NUR";

    #nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";                                 # Nix Packages
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {                                                            # Home Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager-darwin = {                                                            # Home Package Management
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs-darwin";
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, darwin, home-manager }:
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

      # pkgs-darwin = import darwin {
      #   system = "aarch64-darwin";
      #   config.allowUnfree = true;
      # };

      username = "bradley";
      userDescription = "Bradley Davis";
      desktopHostName = "desktop";
      macHostName = "mac";
    in {
      darwinConfigurations = {
        ${macHostName} = darwin.lib.darwinSystem {
          #inherit pkgs-darwin;
          system = "aarch64-darwin";
          modules = [
            ./hosts/${macHostName}/default.nix
            #./hosts/${macHostName}/home.nix
            #home-manager-darwin.darwinModules.home-manager
            #./hosts/${macHostName}/nix.conf
            #home-manager.nixosModules.home-manager {
            #  home-manager.useGlobalPkgs = true;
            #  home-manager.useUserPackages = true;
            #  home-manager.users.${username} = {
            #    imports = [
            #      #./home.nix
            #    ];
            #  };
            #}
          ];
          inputs = { inherit darwin home-manager pkgs; };
        };
      };
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
