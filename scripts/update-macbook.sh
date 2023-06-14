#!/bin/sh

# builds the darwinConfiguration.
# after insalling nix-darwin, we won't need to specify extra-experimental-features anymore
nix build .#darwinConfigurations.macbook.system --extra-experimental-features "nix-command flakes"

# the plan is to now run this to install nix-darwin with our configuration
# ./result/sw/bin/darwin-rebuild switch --flake . # this will fail as we first have to do the following lines

#printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf # read below
#/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t # read below

# now we can finally darwin-rebuild
./result/sw/bin/darwin-rebuild switch --flake .
# ./result/sw/bin/darwin-rebuild switch --flake . --show-trace

# new ? doesnt work right now
# sudo darwin-rebuild switch --flake .#mac
