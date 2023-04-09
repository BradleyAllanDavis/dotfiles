# Welcome to my new Nix Flake dotfiles

I am porting over my existing dotfiles to Nix.

## Build and Run

Build
```
nix build .#hmConfig.bradley.activationPackage
```

Switch
```
sudo nixos-rebuild switch --flake .#bradley
```



























