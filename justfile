alias l13 := laptop13
alias l16 := laptop16

default:
  @just --list --unsorted --justfile {{justfile()}}

desktop:
  sudo nixos-rebuild switch --flake .\#desktop

laptop13:
  sudo nixos-rebuild switch --flake .\#laptop13

laptop16:
  sudo nixos-rebuild switch --flake .\#laptop16

router:
  sudo nixos-rebuild switch --flake .\#router

server:
  sudo nixos-rebuild switch --flake .\#server

macbook:
  @# Needed for first time setup
  @#printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
  @#/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
  @echo 'Rebuild config'
  nix build .\#darwinConfigurations.macbook.system --extra-experimental-features "nix-command flakes"
  ./result/sw/bin/darwin-rebuild switch --flake . --show-trace
