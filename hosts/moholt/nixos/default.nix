{ config, pkgs, lib, ... }:

let 
  hosts = import ../../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../../nixos/modules/system/nixos-base.nix
    ../../../nixos/profiles/server

    ../../../nixos/modules/hardware/networking/server.nix

    ../../../nixos/modules/server/docker
    ../../../nixos/modules/server/docker/containers/navidrome.nix
    ../../../nixos/modules/server/docker/containers/gogs.nix
  ];

  interfaces.eth0.ipv4.addresses = [{
    address = "192.168.1.150";
  }];

  networking.hostName = hosts.moholt.hostname;
}
