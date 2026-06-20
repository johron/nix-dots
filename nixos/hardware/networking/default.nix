{ config, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall = {
      checkReversePath = false;
      allowedUDPPortRanges = [ 
        { from = 32768; to = 60999; } 
      ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}