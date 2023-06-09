{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    autoRepeatDelay = 220;
    autoRepeatInterval = 50;

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}`which xset` r rate 220 80
    '';
  };


}
