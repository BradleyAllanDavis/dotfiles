# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  nixpkgs-unstable,
  # home-manager,
  ...
}:

let
  user = "bradley";
  userDescription = "Bradley";
  # unstable = import <nixpkgs-unstable> {};
  # unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # <home-manager/nixos>
    # <nixpkgs-unstable>
  ];

  # nixpkgs.config = {
  #   packageOverrides = pkgs: with pkgs; {
  #     unstable = import unstableTarball {
  #       config = config.nixpkgs.config;
  #     };
  #   };
  # };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-e3ddf490-ae07-413f-ba18-2dffe2aa03ec".device = "/dev/disk/by-uuid/e3ddf490-ae07-413f-ba18-2dffe2aa03ec";
  boot.initrd.luks.devices."luks-e3ddf490-ae07-413f-ba18-2dffe2aa03ec".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Matamoros";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;

  # Configure keymap in X11
  services.xserver = {
    # enable = true;
    # autoRepeatDelay = 220;
    # autoRepeatInterval = 50;

    layout = "us";
    xkbVariant = "";

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

  # services.xserver.autoRepeatDelay = 220;
  # services.xserver.autoRepeatInterval = 50;
  # services.xserver.displayManager.sessionCommands = ''
  #   ${pkgs.xorg.xset}`which xset` r rate 220 80
  # '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${userDescription}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # home-manager.extraSpecialArgs = { inherit nixpkgs-unstable; }

  # programs.light.enable = true;

  home-manager.useGlobalPkgs = true;

  # home-manager.users.${user} = {
  #   pkgs,
  #   # nixpkgs-unstable,
  #   # unstable ? import <nixpkgs-unstable> { },
  #   ...
  # }: {
  #   # nixpkgs.config = import ./nixpkgs-config.nix
  #   nixpkgs.config.allowUnfree = true;

  #   # programs.bash.enable = true;
  #   home.stateVersion = "22.11";

  #   home.packages = with pkgs; [
  #     xorg.xbacklight

  #     # search nix docs
  #     manix

  #     # starship
  #     # unstable.starship

  #     # shells
  #     fish

  #     # bash
  #     nix-bash-completions

  #     # text editors
  #     neovim
  #     helix

  #     # terminals
  #     alacritty
  #     kitty
  #     # hyper

  #     # window managers
  #     i3-gaps

  #     # git
  #     tig
  #     lazygit

  #     # zsh
  #     zsh
  #     zsh-fzf-tab
  #     # zsh-completions
  #     nix-zsh-completions
  #     zsh-nix-shell
  #     # oh-my-zsh
  #     # fzf-zsh

  #     tmux
  #     python
  #     fzf
  #     bat
  #     ack
  #     direnv
  #     xclip
  #     curl
  #     spotify-tui
  #     spotify-tray
  #     diff-so-fancy
  #     llvm
  #     polybar
  #     # compton, neocomp
  #     dunst
  #     redshift
  #     neomutt
  #     tree
  #     taskwarrior
  #     findutils
  #     trashy
  #     tldr
  #     atool
  #     httpie
  #     htop
  #     ripgrep

  #     # file manager
  #     ranger
  #     vifm

  #     # application launcher
  #     rofi
  #     dmenu

  #     # dotfiles management
  #     # stow
  #     # yadm
  #     # dotdrop
  #     # chezmoi
  #     # dotbot

  #     # bitcoin
  #     bitcoin
  #     # bitcoind

  #     # GUI apps
  #     _1password-gui
  #     brave
  #     expressvpn
  #     spotify
  #     slack
  #     discord
  #     zoom-us
  #     gparted
  #     github-desktop
  #     postman
  #     signal-desktop
  #     tdesktop
  #     whatsapp-for-linux
  #     steam

  #     # jetbrains
  #     jetbrains.idea-ultimate
  #     # jetbrains.datagrip
  #     # jetbrains.clion
  #     # jetbrains.goland
  #     # jetbrains.webstorm
  #     # jetbrains.pycharm-professional
  #     # jetbrains.jdk
  #   ];
  # };

  fonts.fonts = with pkgs; [
    nerdfonts
    # (nerdfonts.override { fonts = [ "SFMono Nerd Font" "Hack Nerd Font Mono" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  # let
  #   unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  # in {
  environment.systemPackages = with pkgs; [
    vim
    git
    python
    tmux
    starship
    xclip
  ];
# }

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}





























