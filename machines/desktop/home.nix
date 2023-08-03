{ pkgs, username, ... }:

let
  base-packages = import ../../base-packages.nix;
  nixos-packages = import ../packages.nix;
  gui-packages = import ../gui-packages.nix;
in
{
  home = {
    packages = (base-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
  };

}
