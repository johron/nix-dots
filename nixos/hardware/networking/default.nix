{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;
}