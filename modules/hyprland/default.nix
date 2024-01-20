{ inputs, pkgs, ... }:
{
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  # };
  home = {
    file = {
      ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    };
  };
}
