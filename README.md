# Welcome to my new Nix Flake dotfiles

I am porting over my existing dotfiles to Nix.

## Build and Run

### Home Manager
```
nix build .#hmConfig.<username>.activationPackage
./result/activate
```

### NixOS
```
nixos-rebuild build --flake .#<hostname>
sudo nixos-rebuild switch --flake .#<hostname>
```



























