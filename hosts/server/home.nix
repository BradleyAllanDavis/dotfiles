{ pkgs, username, ... }:

let
  common-packages = import ../../common-packages.nix;
  nixos-packages = import ../packages.nix;
in
{
  home = {
    packages = (common-packages pkgs) ++ (nixos-packages pkgs);
  };

}
