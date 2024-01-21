{ pkgs, ... }:
{
  services.xserver = {
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    videoDrivers = [ "modesetting" ];

    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable touchpad support
    libinput.enable = true;

    autoRepeatDelay = 220;
    autoRepeatInterval = 80;
    displayManager= {
      # defaultSession = "none+i3";
      # ${pkgs.xorg.xset}`which xset` r rate 220 80
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 200 50
      '';
    };

    # windowManager.i3 = {
    #   enable = true;
    #   package = pkgs.i3-gaps;
    #   extraPackages = with pkgs; [
    #     dmenu # application launcher most people use
    #     i3status # gives you the default i3 status bar
    #     i3lock # default i3 screen locker
    #     # i3blocks # if you are planning on using i3blocks over i3status
    #  ];
    # };
  };
}
