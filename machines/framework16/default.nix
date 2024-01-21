{ pkgs, lib, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/xserver
  ];

}
