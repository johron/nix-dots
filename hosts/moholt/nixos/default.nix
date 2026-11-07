{ config, pkgs, lib, ... }:

let 
  hosts = import ../../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../../nixos/profiles/server

    ../../../nixos/server-modules/system/server-base.nix
    ../../../nixos/server-modules/system/users.nix
    ../../../nixos/server-modules/hardware/networking
    ../../../nixos/server-modules/hardware/quiet
    ../../../nixos/server-modules/hardware/quiet/dell.nix
    ../../../nixos/server-modules/hardware/power
    ../../../nixos/server-modules/docker/containers/navidrome.nix
    ../../../nixos/server-modules/docker/containers/snapotter.nix
    ../../../nixos/server-modules/docker/containers/forgejo.nix
    ../../../nixos/server-modules/docker/containers/beszel.nix
    ../../../nixos/server-modules/docker/containers/johron-no.nix

    ../../../nixos/server-modules/cloudflare
  ];

  networking.interfaces.eth0.ipv4.addresses = [{
    address = "192.168.0.150";
    prefixLength = 24;
  }];

  networking.hostName = hosts.moholt.hostname;
}
