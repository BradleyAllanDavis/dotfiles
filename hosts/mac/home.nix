{ config, pkgs, pkgs-unstable, username, userDescription, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";

  home.username = "bradley";
  #home.homeDirectory = "/home/bradley";
  # home.username = "${username}";
  # home.homeDirectory = "/home/${username}";

  #xdg.enable = true;
  #xdg.configHome = "/home/bradley/.config";

  manual.manpages.enable = false;

  # Raw config files to link to $HOME
  #home.file.".ackrc".source = ../../config/ackrc;

  home.packages = with pkgs; [
    git-crypt
  ];

}
