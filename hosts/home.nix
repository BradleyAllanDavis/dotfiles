# General home-manager configuration

{ pkgs, username, ... }:

let
  nixos-packages = import ./packages.nix;
  common-packages = import ../common-packages.nix;
in
{
  imports = [
    ../config
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "22.11";
    username = "${username}";
    homeDirectory = "/home/${username}";
    packages = (nixos-packages pkgs) ++ (common-packages pkgs);
  };

  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";

  manual.manpages.enable = false;
}
