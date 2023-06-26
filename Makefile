# Makefile

# Hosts/machines
DARWIN_SYSTEMS = macbook
NIXOS_SYSTEMS = desktop laptop13 router server

$(DARWIN_SYSTEMS):
	# Needed for first time setup
	#printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
	#/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
	# Rebuild configs
	nix build .\#darwinConfigurations.$@.system --extra-experimental-features "nix-command flakes"
	./result/sw/bin/darwin-rebuild switch --flake . --show-trace

$(NIXOS_SYSTEMS):
	sudo nixos-rebuild switch --flake .\#$(NIXOS_SYSTEMS)

# Specifies these are not files
.PHONY: $(DARWIN_SYSTEMS) $(NIXOS_SYSTEMS)
