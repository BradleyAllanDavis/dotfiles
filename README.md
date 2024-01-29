# Dotfiles 2.0

Welcome to my new dotfiles based on Nix flakes!

## Dotfiles I like

These are other peoples' dotfiles that have elements I take inspiration from.

- [well documented starter configs](https://github.com/Misterio77/nix-starter-configs)
- [zaney](https://gitlab.com/Zaney/zaneyos)
- [xnm1](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles)
- [malob, darwin, well documented](https://github.com/malob/nixpkgs)
- [matthias](https://github.com/MatthiasBenaets/nixos-config)
- []()
- []()

# Homelab TODOs

## General
- [X] Wrapper script to call flake with hostname
- [X] Nixify tmux
- [X] Fix tmux theme
- [ ] Fix key repeat
- [ ] Fix tmux resurrect
- [ ] Manage secrets
- [ ] Parameterize nixpkgs for consumption by both macOS and NixOS
- [ ] Global color theme [nix-colors](https://github.com/Misterio77/nix-colors)
- [ ] Reverse (natural) mouse scrolling
- [ ] Add justfile target for home-manager

## `server`
- [ ] Migrate to rack (setup and everything)
- [ ] Nixify power settings
- [ ] Figure solution for headless
- [ ] Lighting node
- [ ] Home assistant
- [ ] Nostr
- [ ] Tor

## `desktop`
- [ ] Update encrypted disk password
- [ ] Tiling window manager (i3?, hyprland?)
- [ ] Menu bar
- [ ] Nixify Vim/Neovim config
- [ ] Migrate to zsh
- [ ] Nixify bash
- [ ] Nixify nvim
- [ ] [Configure Plasma?](https://www.youtube.com/watch?v=2r0KnIZX5HY)

## `router`
- [ ] Set up router

## `framework13`
- [ ] Fix all hardware issues
- [ ] Fingerprint sensor
- [ ] Update encrypted disk password

## `framework16`
- [ ]

## Darwin/`macbook`
- [ ] Nixify preferences

## Windows
- [ ] Nix WSL


# Installation Instructions

## NixOS

1. Install latest NixOS via USB ISO
2. Install temp utilities `nix-shell -p git vim`
3. Clone this repo `git clone https://github.com/BradleyAllanDavis/dotfiles ~/.dotfiles` OR transfer via sneakernet
4. Create new directory for machine and integrate `configuration.nix` and `hardware-configuration.nix`
5. Add justfile target for new machine
6. Rebuild NixOS from dotfiles flake
7. Restart machine

## Darwin/macOS

1. Use Determinate Systems nix-installer to install Nix.
2. Load flake

## VMs

- Hardware/VM settings





























