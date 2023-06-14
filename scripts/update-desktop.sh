#!/bin/sh

# export NIXPKGS_ALLOW_INSECURE=1
sudo nixos-rebuild switch --flake .#desktop
# sudo nixos-rebuild switch --show-trace --flake .#desktop
