{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  services.power-profiles-daemon.enable = true;
}