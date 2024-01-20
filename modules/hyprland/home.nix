{ inputs, pkgs, ... }:
{
  home = {
    file = {
      ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    };
  };
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   extraConfig = (import ./hyprland.conf {
  #     inherit (config);
  #   });
  # };
}
