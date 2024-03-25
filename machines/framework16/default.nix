#{ pkgs, lib, username, ... }:
{ stateVersion, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/xserver
  ];

  system.stateVersion = "${stateVersion}";

  boot = {
    # Fix for brightness keys?
    #kernelParams = [ "module_blacklist=hid_sensor_hub" ];
    # Need the latest kernel for WiFi support on Framework
    #kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi";
      };
    };
    # Enable swap on luks
    # initrd.luks.devices = {
    #   "luks-fb2fe72e-f7a9-4e5e-a3ef-73a8e42d4503".device = "/dev/disk/by-uuid/fb2fe72e-f7a9-4e5e-a3ef-73a8e42d4503";
    #   # "luks-f37dedc7-74ea-47b1-83cb-6aad9576fef0".keyFile = "/crypto_keyfile.bin";
    # };
  };

  # Enable illum, a daemon for controlling screen brightness with brightness buttons
  # services.illum.enable = true;
  # hardware.brightnessctl.enable = true;
  hardware.acpilight.enable = true;

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  #networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;

  # Set your time zone.
  #time.timeZone = "America/Matamoros";

  # Select internationalisation properties.
  #i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  #services.xserver = {
    #layout = "us";
    #xkbVariant = "";
  #};

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
    #enable = true;
    #alsa.enable = true;
    #alsa.support32Bit = true;
    #pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.bradley = {
  #   isNormalUser = true;
  #   description = "Bradley";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #     firefox
  #     kate
  #   #  thunderbird
  #   ];
  # };

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
