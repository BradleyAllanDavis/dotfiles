alias f13 := framework13
alias f16 := framework16

# default:
#   @just --list --unsorted --justfile {{justfile()}}

default:
  sudo nixos-rebuild switch --flake .\"$#"

desktop:
  sudo nixos-rebuild switch --flake .\#desktop

framework13:
  sudo nixos-rebuild switch --flake .\#framework13

framework16:
  sudo nixos-rebuild switch --flake .\#framework16

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
