{ config, pkgs, lib, ... }:

let 
  hosts = import ../../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../../server/profiles/server

    ../../../server/modules/system/server-base.nix
    ../../../server/modules/system/users.nix
    ../../../server/modules/hardware/networking
    ../../../server/modules/hardware/quiet
    ../../../server/modules/hardware/quiet/dell.nix
    ../../../server/modules/hardware/power
    ../../../server/modules/docker/containers/navidrome.nix
    ../../../server/modules/docker/containers/snapotter.nix
    # ../../../server/modules/docker/containers/forgejo.nix
    # ../../../server/modules/docker/containers/johron-no.nix

    ../../../server/modules/cloudflare
  ];

  networking.interfaces.eth0.ipv4.addresses = [{
    address = "192.168.0.150";
    prefixLength = 24;
  }];

  networking.hostName = hosts.moholt.hostname;
}
