{
  config,
  pkgs,
  # home-manager,
  username,
  userDescription,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./home.nix
  ];

  system.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${userDescription}";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [];
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      hello
    ];
  };

  fonts.fonts = with pkgs; [
    nerdfonts
    # (nerdfonts.override {
    #   fonts = [
    #     "SFMono Nerd Font"
    #     "Hack Nerd Font Mono"
    #   ];
    # })
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-e3ddf490-ae07-413f-ba18-2dffe2aa03ec" = {
    device = "/dev/disk/by-uuid/e3ddf490-ae07-413f-ba18-2dffe2aa03ec";
    keyFile = "/crypto_keyfile.bin";
  };

  time.timeZone = "America/Matamoros";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 220;
    autoRepeatInterval = 50;

    layout = "us";
    xkbVariant = "";

    # Enable KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # displayManager.sessionCommands = ''
    #   ${pkgs.xorg.xset}`which xset` r rate 220 80
    # '';

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

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ### Networking

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  ### Other stuff

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

}
