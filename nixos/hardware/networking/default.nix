{ config, pkgs, ... }:
{
  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall = {
      checkReversePath = false;
      allowedUDPPortRanges = [ 
        { from = 32768; to = 60999; } 
      ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}