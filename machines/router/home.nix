{ pkgs, username, ... }:

let
  base-packages = import ../../base-packages.nix;
  nixos-packages = import ../packages.nix;
in
{
  home = {
    packages = (base-packages pkgs) ++ (nixos-packages pkgs);
  };

}
