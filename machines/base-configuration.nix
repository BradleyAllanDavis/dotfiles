{ config, inputs, pkgs, username, userDescription, hostName, ... }:

{
  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Matamoros";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable touchpad support
    libinput.enable = true;

    autoRepeatDelay = 220;
    autoRepeatInterval = 80;
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}`which xset` r rate 220 80
    '';

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # displayManager = {
    #   defaultSession = "none+i3";
    # };

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

  # # Hyprland
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
  # environment.sessionVariables = {
  #   WLR_NO_HARDWARE_CURSORS = "1";
  #   NIXOS_OZONE_WL = "1";
  # };
  # hardware = {
  #   opengl.enable = true;
  #   nvidia.modesetting.enable = true;
  # };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    hostName = "${hostName}";
    networkmanager.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${userDescription}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
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

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Needed for naughty packages
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-12.2.3"
  # ];

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

}
