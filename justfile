alias d := desktop
alias f13 := framework13
alias f16 := framework16
alias m := macbook
alias r := router
alias s := server

default:
  @just --list

# default:
#   sudo nixos-rebuild switch --flake .\"$#"

desktop:
  sudo nixos-rebuild switch --flake .\#desktop |& nom

framework13:
  sudo nixos-rebuild switch --flake .\#framework13 |& nom

framework16:
  sudo nixos-rebuild switch --flake .\#framework16

macbook:
  @# Needed for first time setup
  @#printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
  @#/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
  @echo 'Rebuild config'
  @rm ~/.zshrc ~/.bash_profile
  nix build .\#darwinConfigurations.macbook.system --extra-experimental-features "nix-command flakes"
  ./result/sw/bin/darwin-rebuild switch --flake . --show-trace

router:
  sudo nixos-rebuild switch --flake .\#router

server:
  sudo nixos-rebuild switch --flake .\#server

