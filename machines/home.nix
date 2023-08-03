# General home-manager configuration

{ pkgs, username, ... }:

{
  imports = [
    ../config
  ];

  programs.home-manager.enable = true;

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";

  manual.manpages.enable = false;
}
