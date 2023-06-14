{ config, pkgs, ... }:

{
  time.timeZone = "America/Matamoros";
  i18n.defaultLocale = "en_US.UTF-8";

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

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      xclip
      killall
      pciutils
      usbutils
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  nixpkgs.config.allowUnfree = true;

  fonts.fonts = with pkgs; [
    nerdfonts
    # (nerdfonts.override {
    #   fonts = [
    #     "SFMono Nerd Font"
    #     "Hack Nerd Font Mono"
    #   ];
    # })
    # carlito                                 # NixOS
    # vegur                                   # NixOS
    # source-code-pro
    # jetbrains-mono
    # font-awesome                            # Icons
    # corefonts                               # MS
  ];

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };




  # Needed for naughty packages
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-12.2.3"
  # ];
}
