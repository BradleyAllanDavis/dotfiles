# Main system configuration

{ username, hostName, ... }:

{
  services.nix-daemon.enable = true;

  nix.extraOptions = ''
    build-users-group = nixbld
    auto-optimise-store = true
    bash-prompt-prefix = (nix:$name)\040
    experimental-features = nix-command flakes
    extra-nix-path = nixpkgs=flake:nixpkgs
  '';

  nix.gc.user = "bradley";
  nix.gc.automatic = true;

  users.users."${username}" = {
    home = "/Users/${username}";
    # shell = pkgs.zsh;
  };

  networking = {
    computerName = "${hostName}";
    hostName = "${hostName}";
  };

  # fonts = {                               # Fonts
  #   fontDir.enable = true;
  #   fonts = with pkgs; [
  #     source-code-pro
  #     font-awesome
  #     (nerdfonts.override {
  #       fonts = [
  #         "FiraCode"
  #       ];
  #     })
  #   ];
  # };

  # environment = {
  #   shells = with pkgs; [ zsh ];          # Default shell
  #   variables = {                         # System variables
  #     EDITOR = "nvim";
  #     VISUAL = "nvim";
  #   };
  #   systemPackages = with pkgs; [         # Installed Nix packages
  #     # Terminal
  #     ansible
  #     git
  #     ranger

  #     # Doom Emacs
  #     emacs
  #     fd
  #     ripgrep
  #   ];
  # };

  # programs = {                            # Shell needs to be enabled
  #   zsh.enable = true;
  # };

  # services = {
  #   nix-daemon.enable = true;             # Auto upgrade daemon
  # };

  # homebrew = {                            # Declare Homebrew using Nix-Darwin
  #   enable = true;
  #   onActivation = {
  #     autoUpdate = false;                 # Auto update packages
  #     upgrade = false;
  #     cleanup = "zap";                    # Uninstall not listed packages and casks
  #   };
  #   brews = [
  #     "wireguard-tools"
  #   ];
  #   casks = [
  #     "parsec"
  #     "plex-media-player"
  #   ];
  # };

  # nix = {
  #   package = pkgs.nix;
  #   gc = {                                # Garbage collection
  #     automatic = true;
  #     interval.Day = 7;
  #     options = "--delete-older-than 7d";
  #   };
  #   extraOptions = ''
  #     auto-optimise-store = true
  #     experimental-features = nix-command flakes
  #   '';
  # };


}
