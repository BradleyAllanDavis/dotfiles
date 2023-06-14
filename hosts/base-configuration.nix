{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    autoRepeatDelay = 250;
    autoRepeatInterval = 80;

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}`which xset` r rate 220 80
    '';
  };

  # Needed for etcher package
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-12.2.3"
  # ];
  # nixpkgs.config.permittedInsecurePackages = [
  #   "openssl-1.1.1u"
  # ];



}
