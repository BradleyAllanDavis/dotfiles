{ username, stateVersion, ... }:

{
  system.stateVersion = "${stateVersion}";

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

  # AMD GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # Enable automatic login for the user
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "${username}";
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
      enp3s0 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "192.168.7.102";
          prefixLength = 24;
        }];
      };
      enp7s0 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "192.168.7.103";
          prefixLength = 24;
        }];
      };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
