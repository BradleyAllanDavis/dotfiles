# General home-manager configuration
{ username, ... }:
{
  imports = [
    ../config
    ../modules/alacritty
    ../modules/bash
    ../modules/git
    ../modules/i3
    ../modules/nvim
    ../modules/polybar
    ../modules/ssh
    ../modules/starship
    ../modules/tmux
    ../modules/wallpaper
    ../modules/xorg
    ../modules/zsh
  ];

  programs.home-manager.enable = true;
  # programs.hyprland.enable = true;

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";

  # xdg.portal.enable = true;

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "sxiv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };

  manual.manpages.enable = false;

}
