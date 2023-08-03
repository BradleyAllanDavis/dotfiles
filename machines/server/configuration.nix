{ config, pkgs, ... }:

{
  system.stateVersion = "22.11";

  # Bootloader.
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/nvme0n1";
      useOSProber = true;
      enableCryptodisk=true;
    };
    initrd.luks.devices = {
      "luks-93bea6a8-cfb2-4481-b1d6-f16cf7259576".keyFile = "/crypto_keyfile.bin";
      # Enable swap on luks
      "luks-828ad403-f995-40f5-86bf-5d0726f8bdae".device = "/dev/disk/by-uuid/828ad403-f995-40f5-86bf-5d0726f8bdae";
      "luks-828ad403-f995-40f5-86bf-5d0726f8bdae".keyFile = "/crypto_keyfile.bin";
    };
  };

  networking = {
    wireless.enable = false;
    defaultGateway = "192.168.7.1";
    nameservers = ["192.168.7.1" "8.8.8.8"];
    interfaces = {
      eno1 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "192.168.7.101";
          prefixLength = 24;
        }];
      };
      # enp2so = {
      #   useDHCP = false;
      #   ipv4.addresses = [{
      #     address = "192.168.7.101";
      #     prefixLength = 24;
      #   }];
      # };
      # enp6s0 = {
      #   useDHCP = false;
      #   ipv4.addresses = [{
      #     address = "192.168.7.101";
      #     prefixLength = 24;
      #   }];
      # };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
