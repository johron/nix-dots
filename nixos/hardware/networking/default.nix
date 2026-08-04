{ config, pkgs, ... }:
{
  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    networkmanager = {
      enable = true;
      dns = "none";
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    firewall = {
      checkReversePath = false;
      allowedUDPPortRanges = [ 
        { from = 32768; to = 60999; } 
      ];
      allowedUDPPorts = [ 5353 ];
    };
  };

  environment.systemPackages = with pkgs; [
    openconnect
    networkmanagerapplet
  ];

  environment.etc."gnutls/config".text = ''
    [overrides]
    disabled-version = tls1.0
    disabled-version = tls1.1
    disabled-version = tls1.3
  '';
}