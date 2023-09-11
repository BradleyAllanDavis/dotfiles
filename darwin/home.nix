# General home-manager configuration

{ lib, config, pkgs, username, userDescription, hostName, ... }:

let
  base-packages = import ../packages/base-packages.nix;
  darwin-packages = import ../packages/darwin-packages.nix;
in
{
  imports = [
    ../config
    ../modules/alacritty
    ../modules/bash
    ../modules/git
    ../modules/nvim
    ../modules/ssh
    ../modules/starship
    ../modules/tmux
    ../modules/wallpaper
    ../modules/xorg
    ../modules/zsh
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "22.11";
    username = "${username}";
    # homeDirectory = "/Users/${username}";
    packages = (darwin-packages pkgs) ++ (base-packages pkgs);
  };

  # xdg.enable = true;
  # xdg.configHome = "/Users/${username}/.config";

  manual.manpages.enable = false;

}
