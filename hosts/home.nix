# General home-manager configuration
{
  config,
  pkgs,
  username,
  userDescription,
  ...
}:

let
  packages = import ./packages.nix;
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
    packages = packages pkgs;
  };

  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";

  manual.manpages.enable = false;
}
