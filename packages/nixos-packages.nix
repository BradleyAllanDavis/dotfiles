let
  my-python-packages = ps: with ps; [
    # csv
    matplotlib
    numpy
    pillow
    torch
    torchvision
  ];
in
pkgs: with pkgs; [
  atool
  # compton
  # bitcoind-knots
  direnv
  dunst
  findutils
  fzf-zsh
  httpie
  hyprpaper
  # kotlin
  jupyter-all
  k3s
  k9s
  llvm
  # neocomp
  neofetch
  neomutt
  nil
  nix-bash-completions
  nix-direnv
  nix-index
  nix-zsh-completions
  nodejs
  nostr-rs-relay
  openjdk
  # oraclejdk
  podman
  pstree
  (python3.withPackages my-python-packages)
  rustup
  spotify-tui
  taskwarrior
  trashy
  vifm
  waybar
  wayland
  wdisplays
  xclip
  xorg.xbacklight
  # zsh-completions
  zsh-fzf-tab
  zsh-nix-shell
]
