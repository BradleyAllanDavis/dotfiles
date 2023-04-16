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
  home.packages = packages pkgs;

  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  # home-manager.users.${username} = { pkgs, ... }: {
  #   programs.home-manager.enable = true;
  #   home.stateVersion = "22.11";

  #   home.username = "${username}";
  #   home.homeDirectory = "/home/${username}";

  #   xdg.enable = true;
  #   xdg.configHome = "/home/${username}/.config";

  #   manual.manpages.enable = false;

  #   # Raw config files to link to $HOME
  #   home.file.".ackrc".source = ../../config/ackrc;
  # };

  programs.home-manager.enable = true;
  home.stateVersion = "22.11";

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  xdg.enable = true;
  xdg.configHome = "/home/${username}/.config";

  manual.manpages.enable = false;

  # Raw config files to link to $HOME
  home.file.".ackrc".source = ../../config/ackrc;

}
