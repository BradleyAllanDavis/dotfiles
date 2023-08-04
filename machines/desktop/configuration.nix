{ pkgs, inputs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-e3ddf490-ae07-413f-ba18-2dffe2aa03ec" = {
    device = "/dev/disk/by-uuid/e3ddf490-ae07-413f-ba18-2dffe2aa03ec";
    keyFile = "/crypto_keyfile.bin";
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };

  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
