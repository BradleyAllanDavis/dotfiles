{ config, pkgs, ... }:

let

  # pkgs-unstable = import <pkgs-unstable> {};

in

{
  home.username = "bradley";
  home.homeDirectory = "/home/bradley";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  manual.manpages.enable = false;

  home.packages = with pkgs; [
    xorg.xbacklight

    # search nix docs
    manix

    # shells
    fish

    # bash
    nix-bash-completions

    # text editors
    neovim
    helix

    # terminals
    alacritty
    kitty
    # hyper

    # window managers
    i3-gaps

    # git
    tig
    lazygit

    # zsh
    zsh
    zsh-fzf-tab
    # zsh-completions
    nix-zsh-completions
    zsh-nix-shell
    # oh-my-zsh
    # fzf-zsh

    tmux
    python
    fzf
    bat
    ack
    direnv
    xclip
    curl
    spotify-tui
    spotify-tray
    diff-so-fancy
    llvm
    polybar
    # compton, neocomp
    dunst
    redshift
    neomutt
    tree
    taskwarrior
    findutils
    trashy
    tldr
    atool
    httpie
    htop
    ripgrep

    # file manager
    ranger
    vifm

    # application launcher
    rofi
    dmenu

    # dotfiles management
    # stow
    # yadm
    # dotdrop
    # chezmoi
    # dotbot

    # bitcoin
    bitcoin
    # bitcoind

    # GUI apps
    _1password-gui
    brave
    expressvpn
    spotify
    slack
    discord
    zoom-us
    gparted
    github-desktop
    postman
    signal-desktop
    tdesktop
    whatsapp-for-linux
    steam

    # jetbrains
    jetbrains.idea-ultimate
    # jetbrains.datagrip
    # jetbrains.clion
    # jetbrains.goland
    # jetbrains.webstorm
    # jetbrains.pycharm-professional
    # jetbrains.jdk
  ];
  # ] ++ (with pkgs-unstable; [
  #   starship
  # ]);




}
