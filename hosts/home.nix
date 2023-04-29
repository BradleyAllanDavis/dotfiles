# General home-manager configuration

{ pkgs, username, ... }:

let
  common-packages = import ../common-packages.nix;
  nixos-packages = import ./packages.nix;
  gui-packages = import ./gui-packages.nix;
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
    packages = (common-packages pkgs) ++ (nixos-packages pkgs) ++ (gui-packages pkgs);
  };

  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";

  manual.manpages.enable = false;
}
