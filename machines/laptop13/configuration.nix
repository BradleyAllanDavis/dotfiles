{ pkgs, stateVersion, ... }:

{
  system.stateVersion = "${stateVersion}";

  boot = {
    # Fix for brightness keys?
    kernelParams = [ "module_blacklist=hid_sensor_hub" ];
    # Need the latest kernel for WiFi support on Framework
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    # Enable swap on luks
    initrd.luks.devices = {
      "luks-f37dedc7-74ea-47b1-83cb-6aad9576fef0".device = "/dev/disk/by-uuid/f37dedc7-74ea-47b1-83cb-6aad9576fef0";
      "luks-f37dedc7-74ea-47b1-83cb-6aad9576fef0".keyFile = "/crypto_keyfile.bin";
    };
  };

  # Enable illum, a daemon for controlling screen brightness with brightness buttons
  # services.illum.enable = true;
  # hardware.brightnessctl.enable = true;
  hardware.acpilight.enable = true;

  # Battery optimization
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_BOOST_ON_BAT = 0;
  #     CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
  #     START_CHARGE_THRESH_BAT0 = 90;
  #     STOP_CHARGE_THRESH_BAT0 = 97;
  #     RUNTIME_PM_ON_BAT = "auto";
  #   };
  # };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver.videoDrivers = [ "modesetting" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
