{ pkgs, ... }:

let
  base-packages = import ../../base-packages.nix;
  nixos-packages = import ../packages.nix;
  gui-packages = import ../gui-packages.nix;
  laptop-packages = import ../laptop-packages.nix;
in
{
  home = {
    stateVersion = "22.11";
    packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs) ++ (laptop-packages pkgs);
  };

}
