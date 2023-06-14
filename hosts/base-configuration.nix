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


}
