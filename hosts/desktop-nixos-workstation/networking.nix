{ config, pkgs, ... }:
let
  hosts = import ../../config/hosts.nix;
in

{
  environment.systemPackages = with pkgs; [
    protonvpn-gui
    wireguard-tools
  ];

  networking.hostName = hosts.nixstation.hostname;
  networking.networkmanager.enable = true;

  networking.firewall.checkReversePath = false;
}