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
  # Works with "desktop" NixOS target
  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  # home-manager.users.${username} = { pkgs, ... }: {
  #   programs.home-manager.enable = true;
  #   home.stateVersion = "22.11";
  #   home.username = "${username}";
  #   home.homeDirectory = "/home/${username}";
  #   home.packages = packages pkgs;
  #   xdg.enable = true;
  #   xdg.configHome = "/home/${username}/.config";
  #   manual.manpages.enable = false;
  #   home.file.".ackrc".source = ../../config/ackrc;
  # };

  # Works with "hmConfig" target
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.packages = packages pkgs;
  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";
  manual.manpages.enable = false;
  home.file.".ackrc".source = ../../config/ackrc;
}
