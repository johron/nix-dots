{ config, pkgs, lib, ... }:

let 
  hosts = import ../../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../../nixos/modules/system/nixos-base.nix
    ../../../nixos/profiles/server

    ../../../nixos/server-modules/hardware/networking
    ../../../nixos/server-modules/docker
    ../../../nixos/server-modules/docker/containers/navidrome.nix
    ../../../nixos/server-modules/docker/containers/gogs.nix
  ];

  interfaces.eth0.ipv4.addresses = [{
    address = "192.168.1.150";
  }];

  networking.hostName = hosts.moholt.hostname;
}
