{ pkgs, username, ... }:

let
  common-packages = import ../../common-packages.nix;
  nixos-packages = import ../packages.nix;
  gui-packages = import ../gui-packages.nix;
  laptop-packages = import ./laptop-packages.nix;
in
{
  home = {
    packages = (common-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs) ++ (laptop-packages pkgs);
  };

}
