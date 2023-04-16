# { pkgs, ... }:
{
  imports = [
    ./home.nix
    ./brew.nix
    ./preferences.nix
  ];

  services.nix-daemon.enable = true;

  nix.extraOptions = ''
    build-users-group = nixbld
    auto-optimise-store = true
    bash-prompt-prefix = (nix:$name)\040
    experimental-features = nix-command flakes
    extra-nix-path = nixpkgs=flake:nixpkgs
  '';

  nix.gc.user = "bradley";
  nix.gc.automatic = true;


}
