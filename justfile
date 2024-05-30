alias d := desktop
alias f13 := framework13
alias f16 := framework16
alias m := macbook
alias r := router
alias s := server

zshrc := "${HOME}/.zshrc"
bash_profile := "${HOME}/.bash_profile"

# TODO: Make generic function to rebuild nixos

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
  #just clean-macbook
  nix build .\#darwinConfigurations.macbook.system --extra-experimental-features "nix-command flakes"
  ./result/sw/bin/darwin-rebuild switch --flake . --show-trace

router:
  sudo nixos-rebuild switch --flake .\#router

server:
  sudo nixos-rebuild switch --flake .\#server

macbook-first-time-setup:
  @printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
  @/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t

clean-macbook:
  echo 'Clean macbook'
  if [ -f {{zshrc}} ]; then
  echo "Removing .zshrc..."
  rm {{zshrc}}
  else
  echo ".zshrc not found. Skipping removal."
  fi
  if [ -f {{bash_profile}} ]; then
  echo "Removing .bash_profile..."
  rm {{bash_profile}}
  else
  echo ".bash_profile not found. Skipping removal."
  fi







