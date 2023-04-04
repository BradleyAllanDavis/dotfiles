{ config, pkgs, ... }:

{
  home.username = "bradley";
  home.homeDirectory = "/home/bradley";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  manual.manpages.enable = false;

}
