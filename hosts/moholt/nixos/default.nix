{ config, pkgs, lib, ... }:

let 
  hosts = import ../../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../../server/profiles/server

    ../../../server/modules/system/server-base.nix
    ../../../server/modules/hardware/networking
    ../../../server/modules/hardware/quiet
    ../../../server/modules/hardware/power
    ../../../server/modules/hardware/dell.nix
    ../../../server/modules/docker/containers/navidrome.nix
    ../../../server/modules/docker/containers/snapotter.nix
    # ../../../server/modules/docker/containers/forgejo.nix
    # ../../../server/modules/docker/containers/johron-no.nix

    ../../../server/modules/cloudflare
  ];

  interfaces.eth0.ipv4.addresses = [{
    address = "192.168.1.150";
  }];

  networking.hostName = hosts.moholt.hostname;
}
