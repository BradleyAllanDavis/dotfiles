{ stateVersion, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/xserver
  ];

  system.stateVersion = "${stateVersion}";

  boot = {
    # Fix for brightness keys?
    #kernelParams = [ "module_blacklist=hid_sensor_hub" ];
    # Need the latest kernel for WiFi support on Framework
    #kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi";
      };
    };
    # Enable swap on luks
    # initrd.luks.devices = {
      # "luks-fb2fe72e-f7a9-4e5e-a3ef-73a8e42d4503".device = "/dev/disk/by-uuid/fb2fe72e-f7a9-4e5e-a3ef-73a8e42d4503";
    #   # "luks-f37dedc7-74ea-47b1-83cb-6aad9576fef0".keyFile = "/crypto_keyfile.bin";
    # };
  };

  # Enable illum, a daemon for controlling screen brightness with brightness buttons
  # services.illum.enable = true;
  # hardware.brightnessctl.enable = true;
  hardware.acpilight.enable = true;

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
