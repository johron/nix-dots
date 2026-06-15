{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  # chromecast
  networking.firewall.allowedUDPPortRanges = [ 
    { from = 32768; to = 60999; } 
  ];
}