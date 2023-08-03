{ pkgs, username, ... }:

let
  base-packages = import ../../base-packages.nix;
  nixos-packages = import ../packages.nix;
in
{
  home = {
    stateVersion = "22.11";
    packages = (base-packages pkgs) ++ (nixos-packages pkgs);
  };

}
