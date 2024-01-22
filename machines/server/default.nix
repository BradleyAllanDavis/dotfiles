{ stateVersion, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/xserver
  ];

  system.stateVersion = "${stateVersion}";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi";
      };
      #grub = {
      #  enable = true;
      #  #device = "/dev/nvme0n1";
      #  useOSProber = true;
      #  #enableCryptodisk=true;
      #};
    };
  };

  # AMD GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

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
      enp6s0 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "192.168.7.103";
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

  # Hard drives
  # fileSystems = {
  #   "/mnt/disk1" = {
  #     device = "/dev/sda";
  #     fsType = "ext4";
  #   };
  #   "/mnt/disk2" = {
  #     device = "/dev/sdb";
  #     fsType = "ext4";
  #   };
  # };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
