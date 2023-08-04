{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # If issues with dual monitors
  # boot.kernelParams = [
  #   "video=DP-1:2560x1440@144"
  #   "video=DP-2:2560x1440@144"
  # ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/86dd93af-22b4-40db-8f64-233cdebb0bb0";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-e16e890f-297a-42b7-9fa2-1671ac1d4c79".device = "/dev/disk/by-uuid/e16e890f-297a-42b7-9fa2-1671ac1d4c79";

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/E751-DFD9";
      fsType = "vfat";
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/dbe75bce-94df-4d68-9383-1a8c44ba64d1"; }
    ];

  # AMD GPU Support
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    rocm-opencl-icd
    rocm-opencl-runtime
  ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp11s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp10s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
