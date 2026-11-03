{ config, pkgs, ... }:

{
  networking = {
    useDHCP = false; 

    networkmanager.enable = true; 

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