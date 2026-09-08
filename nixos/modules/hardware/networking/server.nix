{ config, pkgs, ... }:

{
  networking = {
    useDHCP = false; 

    networkmanager.enable = true; 

    interfaces.eth0.ipv4.addresses = [{
      prefixLength = 24;
    }];

    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}