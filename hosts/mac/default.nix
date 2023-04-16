{ pkgs, ... }:
{
  services.nix-daemon.enable = true;
  # services.nix-daemon.package = pkgs.nixFlakes;


  nix.extraOptions = ''
    build-users-group = nixbld
    auto-optimise-store = true
    bash-prompt-prefix = (nix:$name)\040
    experimental-features = nix-command flakes
    extra-nix-path = nixpkgs=flake:nixpkgs
  '';

  # from nix.conf
  # nix.build-users-group = "nixbld";
  # nix.auto-optimise-store = true;

  nix.gc.user = "bradley";
  nix.gc.automatic = true;
  # launchd.daemons.nix-gc.serviceConfig.bradley = "admin";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.bradley = { pkgs, ... }: {
    programs.home-manager.enable = true;

    home.stateVersion = "22.11";

    home.username = "bradley";
    # home.homeDirectory = "/Users/bradley";

    #xdg.enable = true;
    #xdg.configHome = "/home/bradley/.config";

    manual.manpages.enable = false;

    # Raw config files to link to $HOME
    home.file.".ackrc".source = ../../config/ackrc;

    home.packages = with pkgs; [
      git-crypt
    ];

    # programs.tmux = { # my tmux configuration, for example
    #   enable = true;
    #   keyMode = "vi";
    #   clock24 = true;
    #   historyLimit = 10000;
    #   plugins = with pkgs.tmuxPlugins; [
    #     vim-tmux-navigator
    #     gruvbox
    #   ];
    #   extraConfig = ''
    #     new-session -s main
    #     bind-key -n C-a send-prefix
    #   '';
    # };
  };

  system.defaults.dock.autohide = true;

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = false;
    casks = [
      "alacritty"
      "aldente"
      "alfred"
      "appcleaner"
      "arc"
      "atomic-wallet"
      "bartender"
      "beyond-compare"
      "bitcoin-core"
      "calibre"
      "charles"
      "chatgpt"
      "cleanshot"
      "coteditor"
      "dash"
      "discord"
      "electrum"
      "evernote"
      "exodus"
      "fig"
      "flux"
      "font-sf-mono-nerd-font"
      "github"
      "google-earth-pro"
      "handbrake"
      "hazel"
      "insomnia"
      "istat-menus"
      "iterm2"
      "joplin"
      "karabiner-elements"
      "kitty"
      "ledger-live"
      "malwarebytes"
      "monitorcontrol"
      "ngrok"
      "nightowl"
      "nocturnal"
      "notion"
      "obsidian"
      "paw"
      "postman"
      "proxyman"
      "qlcolorcode"
      "qlmarkdown"
      "qlplayground"
      "qlprettypatch"
      "qlstephen"
      "qlswift"
      "qlvideo"
      "quicklook-csv"
      "quicklook-json"
      "quitter"
      "ransomwhere"
      "roam-research"
      "rocket"
      "spotify"
      "tower"
      "trezor-suite"
      "tripmode"
      "tunnelblick"
      "visual-studio-code"
      "warp"
      #"hammerspoon"
      #"amethyst"
      #"logseq"
      #"iina"
    ];
  };
}
